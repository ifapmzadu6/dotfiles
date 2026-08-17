#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "$0")" && pwd)
source "$SCRIPT_DIR/lib.sh"

# .vimrc
link_dotfile "$SCRIPT_DIR/vimrc" "$HOME/.vimrc"

# plugins
PLUGINS_DIR="$HOME/.vim/pack/mypackage/start"
rm -rf -- "$PLUGINS_DIR"
mkdir -p "$PLUGINS_DIR"

plugins=(
    "https://github.com/w0ng/vim-hybrid.git"
    "https://github.com/preservim/nerdtree.git"
    "https://github.com/airblade/vim-gitgutter.git"
    "https://github.com/itchyny/lightline.vim.git"
    "https://github.com/editorconfig/editorconfig-vim.git"
    "https://github.com/preservim/vim-markdown.git"
    "https://github.com/leafgarland/typescript-vim.git"
)

for plugin_url in "${plugins[@]}"; do
    plugin_name=$(basename "${plugin_url}" .git)
    plugin_dir="${PLUGINS_DIR}/${plugin_name}"
    echo "Installing Vim plugin: $plugin_name"
    git clone --depth 1 "$plugin_url" "$plugin_dir"
done
