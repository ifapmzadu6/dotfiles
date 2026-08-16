#!/usr/bin/env bash
set -euo pipefail

DOTPATH="$HOME/.dotfiles"
REPO_URL="https://github.com/ifapmzadu6/dotfiles.git"
UPDATE_REPOSITORY=1

# Check if git is installed
if ! command -v git >/dev/null 2>&1; then
    echo "Error: git is not installed. Please install git first."
    exit 1
fi

# Determine whether the checked-out script or a curl/bootstrap copy is running.
SCRIPT_PATH=${BASH_SOURCE[0]:-}
if [ -n "$SCRIPT_PATH" ] && [ -f "$SCRIPT_PATH" ]; then
    SCRIPT_DIR=$(cd -- "$(dirname -- "$SCRIPT_PATH")" && pwd)
else
    SCRIPT_DIR=""
fi

if [ -n "$SCRIPT_DIR" ] && REPO_DIR=$(git -C "$SCRIPT_DIR" rev-parse --show-toplevel 2>/dev/null); then
    echo "Using local repository: $REPO_DIR"
else
    echo "Bootstrap mode detected"
    if [ ! -e "$DOTPATH" ]; then
        echo "Cloning dotfiles to $DOTPATH..."
        git clone "$REPO_URL" "$DOTPATH"
        UPDATE_REPOSITORY=0
    elif ! REPO_DIR=$(git -C "$DOTPATH" rev-parse --show-toplevel 2>/dev/null); then
        echo "Error: $DOTPATH exists but is not a Git repository." >&2
        exit 1
    else
        echo "Using existing repository: $DOTPATH"
    fi
    if [ -z "${REPO_DIR:-}" ]; then
        REPO_DIR=$DOTPATH
    fi
fi

if [ "$UPDATE_REPOSITORY" -eq 1 ]; then
    if [ -n "$(git -C "$REPO_DIR" status --porcelain)" ]; then
        echo "Repository has local changes; skipping update."
    elif git -C "$REPO_DIR" rev-parse --verify '@{upstream}' >/dev/null 2>&1; then
        echo "Updating repository..."
        git -C "$REPO_DIR" pull --ff-only
    else
        echo "No upstream branch is configured; skipping update."
    fi
fi

# Run setup scripts
echo "Running setup scripts..."
bash "$REPO_DIR/setup_gitconfig.sh"
bash "$REPO_DIR/setup_vim.sh"
bash "$REPO_DIR/setup_inputrc.sh"
bash "$REPO_DIR/setup_zsh.sh"

echo "Installation complete!"
