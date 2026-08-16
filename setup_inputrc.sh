#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "$0")" && pwd)
source "$SCRIPT_DIR/lib.sh"

# .inputrc
link_dotfile "$SCRIPT_DIR/inputrc" "$HOME/.inputrc"
