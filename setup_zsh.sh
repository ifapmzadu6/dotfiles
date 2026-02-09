#!/bin/bash
set -e

SCRIPT_DIR=$(cd -- "$(dirname -- "$0")" && pwd)

SOURCE_LINE="source \"$SCRIPT_DIR/zshrc\""

# Add source line to .zshrc if not already present
if [ ! -f "$HOME/.zshrc" ] || ! grep -qF "$SOURCE_LINE" "$HOME/.zshrc"; then
    echo "$SOURCE_LINE" >> "$HOME/.zshrc"
fi
