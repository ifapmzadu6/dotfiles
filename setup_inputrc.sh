#!/bin/bash
set -e

SCRIPT_DIR=$(cd -- "$(dirname -- "$0")" && pwd)

# .inputrc
ln -sf "$SCRIPT_DIR/inputrc" "$HOME/.inputrc"