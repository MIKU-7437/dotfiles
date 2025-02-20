#!/bin/bash

set -e  # Exit immediately if any command fails

KANATA_CONFIG="$HOME/.config/kanata/kanata.kbd"
SERVICE_FILE="$HOME/.config/systemd/user/kanata.service"
UDEV_RULES_FILE="/etc/udev/rules.d/99-input.rules"

echo "Starting Kanata setup..."

### 1. Ensure necessary groups exist
echo "Creating and adding user to necessary groups..."
#if ! grep -q "^uinput:" /etc/group; then
#    sudo groupadd uinput
#    groupadd -g 1001 uinput
#    groupadd -g 994 input
#fi
sudo groupadd -f uinput
sudo groupadd -f -g 1001 uinput
sudo groupadd -f -g 994 input

sudo usermod -aG input "$(whoami)"
sudo usermod -aG uinput "$(whoami)"
echo "User added to input and uinput groups."

### 2. Set up udev rules for uinput
echo "Setting up udev rules..."
echo 'KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"' | sudo tee "$UDEV_RULES_FILE" > /dev/null
#sudo udevadm control --reload-rules && sudo udevadm trigger
echo "Udev rules applied."

### 3. Load uinput module
echo "Loading uinput module..."
sudo modprobe uinput
echo "uinput module loaded."

### 4. Create systemd user directory
echo "Ensuring systemd user directory exists..."
mkdir -p "$(dirname "$SERVICE_FILE")"

### 5. Create Kanata systemd service
echo "Creating Kanata systemd service..."
cat <<EOF >"$SERVICE_FILE"
[Unit]
Description=Kanata keyboard remapper
Documentation=https://github.com/jtroo/kanata

[Service]
Environment=PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/bin
Environment=DISPLAY=:0
Environment=HOME=$HOME
Type=simple
ExecStart=/usr/bin/sh -c 'exec \$(which kanata) --cfg $KANATA_CONFIG'
Restart=no

[Install]
WantedBy=default.target
EOF
echo "Systemd service file created at: $SERVICE_FILE"

### 6. Reload systemd, enable and start Kanata
echo "Enabling and starting Kanata systemd service..."
systemctl --user daemon-reload
systemctl --user enable kanata.service
systemctl --user restart kanata.service
echo "Kanata systemd service has been successfully enabled and started."

### 7. Check service status
systemctl --user status kanata.service --no-pager

echo "Kanata setup completed successfully!"

