#!/bin/bash
set -e

SCRIPT_DIR=$(cd -- "$(dirname -- "$0")" && pwd)

# .zshrc
ln -sf "$SCRIPT_DIR/zshrc" "$HOME/.zshrc"
