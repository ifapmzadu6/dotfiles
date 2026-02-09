#!/bin/bash
set -e

DOTPATH="$HOME/.dotfiles"
REPO_URL="https://github.com/ifapmzadu6/dotfiles.git"

# Check if git is installed
if ! command -v git >/dev/null 2>&1; then
    echo "Error: git is not installed. Please install git first."
    exit 1
fi

# Determine if running locally (inside the repo) or via curl/bootstrap
# Try to get the directory of the script
if [ -f "$0" ]; then
    SCRIPT_DIR=$(cd -- "$(dirname -- "$0")" && pwd)
else
    SCRIPT_DIR=""
fi

if [ -n "$SCRIPT_DIR" ] && [ -d "$SCRIPT_DIR/.git" ]; then
    # Running from a valid local git repository
    echo "Running locally from $SCRIPT_DIR..."
    cd "$SCRIPT_DIR"
    echo "Updating repository..."
    git pull
else
    # Bootstrap mode: Clone or update to ~/.dotfiles
    echo "Bootstrap mode detected."
    if [ ! -d "$DOTPATH" ]; then
        echo "Cloning dotfiles to $DOTPATH..."
        git clone "$REPO_URL" "$DOTPATH"
    else
        echo "Dotfiles directory ($DOTPATH) already exists. Updating..."
        cd "$DOTPATH"
        git pull
    fi
    cd "$DOTPATH"
fi

# Run setup scripts
echo "Running setup scripts..."
./setup_gitconfig.sh
./setup_vim.sh
./setup_inputrc.sh
./setup_zsh.sh

echo "Installation complete!"