#!/bin/bash

set -e

SERVICE_FILE="$HOME/.config/systemd/user/kanata.service"
KANATA_CONFIG="$HOME/kanata.kbd"

# Ensure the systemd user directory exists
prepare_systemd_directory() {
    if [ ! -d "$(dirname "$SERVICE_FILE")" ]; then
        echo "Creating systemd user directory..."
        mkdir -p "$(dirname "$SERVICE_FILE")"
    fi
}

# Create or update the Kanata service file
create_service_file() {
    echo "Creating or updating the Kanata systemd service file..."
    cat <<EOF >"$SERVICE_FILE"
[Unit]
Description=Kanata keyboard remapper
Documentation=https://github.com/jtroo/kanata

[Service]
Environment=PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/bin
Environment=DISPLAY=:0
Environment=HOME=$HOME
Type=simple
ExecStart=/usr/bin/kanata --cfg $KANATA_CONFIG
Restart=never

[Install]
WantedBy=default.target
EOF
    echo "Service file created or updated at: $SERVICE_FILE"
}

# Reload systemd user daemon and enable the service
enable_and_start_service() {
    echo "Reloading systemd daemon..."
    systemctl --user daemon-reload

    echo "Enabling Kanata service..."
    systemctl --user enable kanata.service

    echo "Starting Kanata service..."
    systemctl --user restart kanata.service

    echo "Kanata service has been successfully enabled and started."
}

# Main function to run the setup steps
main() {
    # Check if the Kanata configuration file exists
    if [ ! -f "$KANATA_CONFIG" ]; then
        echo "Kanata configuration file not found at: $KANATA_CONFIG"
        echo "Make sure your configuration is available at this location."
        exit 1
    fi

    prepare_systemd_directory
    create_service_file
    enable_and_start_service
}

main
