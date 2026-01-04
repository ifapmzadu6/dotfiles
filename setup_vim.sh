#!/bin/bash
set -e

SCRIPT_DIR=$(cd -- "$(dirname -- "$0")" && pwd)

# .vimrc
ln -sf "$SCRIPT_DIR/vimrc" "$HOME/.vimrc"

# plugins
rm -rf "$HOME/.vim"
mkdir -p "$HOME/.vim/pack/mypackage/start"
cd "$HOME/.vim/pack/mypackage/start"
git clone https://github.com/w0ng/vim-hybrid.git
git clone https://github.com/scrooloose/nerdtree.git
git clone https://github.com/airblade/vim-gitgutter.git
git clone https://github.com/itchyny/lightline.vim.git
git clone https://github.com/editorconfig/editorconfig-vim.git
git clone https://github.com/preservim/vim-markdown.git
git clone https://github.com/leafgarland/typescript-vim.git
