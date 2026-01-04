#!/bin/bash
set -e

SCRIPT_DIR=$(cd -- "$(dirname -- "$0")" && pwd)
cd "$SCRIPT_DIR"

# update
git pull

# run
./setup_gitconfig.sh
./setup_vim.sh
