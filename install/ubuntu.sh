#!/bin/bash

set -e

# === Description ===
# Installs packages listed in a file using apt on Ubuntu/Debian systems.
# Usage: ./install_plugins_ubuntu.sh <packages_file>

# === Check arguments ===
if [ $# -eq 0 ]; then
    echo "Usage: $0 <packages_file>"
    exit 1
fi

PACKAGES_FILE="$1"

if [ ! -f "$PACKAGES_FILE" ]; then
    echo "File $PACKAGES_FILE not found. Please make sure the file exists."
    exit 1
fi

# === Helper: Check if a package is installed ===
is_installed() {
    dpkg -s "$1" &>/dev/null
}

# === Helper: Install a package ===
install_package() {
    local package="$1"
    echo "Checking installation for package: $package..."

    if is_installed "$package"; then
        echo "$package is already installed."
    else
        if apt-cache show "$package" &>/dev/null; then
            echo "Installing $package with apt..."
            sudo apt-get install -y "$package"
        else
            echo "Package $package not found in apt repositories. Skipping."
        fi
    fi
}

# === Main loop ===
while IFS= read -r package; do
    # Skip comments and empty lines
    [[ -z "$package" || "$package" =~ ^# ]] && continue
    install_package "$package"
done < "$PACKAGES_FILE"

echo "✅ All packages have been processed."

