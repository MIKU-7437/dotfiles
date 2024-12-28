#!/bin/bash

set -e

# Check if an argument is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <plugins_file>"
    exit 1
fi

PLUGINS_FILE="$1"

# Check if the plugins file exists
if [ ! -f "$PLUGINS_FILE" ]; then
    echo "File $PLUGINS_FILE not found. Please make sure the file exists."
    exit 1
fi

# Check if a package is already installed
is_installed() {
    pacman -Q "$1" &>/dev/null
}

# Install a package using pacman or yay
install_plugin() {
    local plugin="$1"
    echo "Checking installation for plugin: $plugin..."

    if is_installed "$plugin"; then
        echo "$plugin is already installed."
    else
        if pacman -Si "$plugin" &>/dev/null; then
            echo "Installing $plugin with pacman..."
            sudo pacman -S --noconfirm "$plugin"
        elif yay -Si "$plugin" &>/dev/null; then
            echo "Installing $plugin with yay..."
            yay -S --noconfirm "$plugin"
        else
            echo "Package $plugin not found in pacman or AUR. Skipping."
        fi
    fi
}

# Process each plugin from the file
while IFS= read -r plugin; do
    [ -z "$plugin" ] && continue  # Skip empty lines
    install_plugin "$plugin"
done < "$PLUGINS_FILE"

echo "All plugins have been processed."
