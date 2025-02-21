#!/bin/bash

# Define paths
TMUX_CONF="$HOME/.config/tmux/tmux.conf"
TPM_DIR="$HOME/.tmux/plugins/tpm"

# Ensure tmux.conf exists
if [ ! -f "$TMUX_CONF" ]; then
    echo "Error: $TMUX_CONF not found. Please create your tmux config."
    exit 1
fi

# Check if TPM is installed
if [ ! -d "$TPM_DIR" ]; then
    echo "🔹 Installing Tmux Plugin Manager (TPM)..."
    git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
else
    echo "✅ TPM is already installed."
fi

# Reload tmux configuration
echo "🔄 Reloading tmux configuration..."
tmux source-file "$TMUX_CONF"

# Ensure tmux is running before installing plugins
if pgrep -x "tmux" > /dev/null; then
    echo "🔌 Installing tmux plugins..."
    "$TPM_DIR/bin/install_plugins"
    echo "🔄 Updating tmux plugins..."
    "$TPM_DIR/bin/update_plugins" all
else
    echo "⚠️ Tmux is not running. Start tmux and press 'C-Space + I' to install plugins."
fi

echo "✅ Setup complete!"

