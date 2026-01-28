#!/usr/bin/env zsh

set -e

ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"

echo "Starting Zsh setup..."

### 1. Change default shell to Zsh
if [[ "$SHELL" != *"zsh" ]]; then
    echo "Changing default shell to Zsh..."
    chsh -s "$(which zsh)"
    echo "Default shell changed to Zsh. You may need to log out and log back in."
else
    echo "Zsh is already the default shell."
fi

### 2. Install Zinit plugin manager
if [[ ! -d $ZINIT_HOME ]]; then
    echo "Installing Zinit..."
    mkdir -p "$(dirname "$ZINIT_HOME")"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
    ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"
    zsh -c 'source "$ZINIT_HOME/zinit.zsh"'


    echo "Zinit installed successfully."
else
    echo "Zinit is already installed."
fi

### 3. Reload Zsh configuration
echo "Reloading Zsh configuration..."
exec zsh

echo "Zsh setup completed successfully!"

