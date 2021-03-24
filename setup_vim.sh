#!/bin/bash

# .vimrc
unlink ~/.vimrc
ln -sf $(pwd)/vimrc ~/.vimrc

# plugins
rm -rf ~/.vim
mkdir -p ~/.vim/pack/mypackage/start
cd ~/.vim/pack/mypackage/start
git clone https://github.com/w0ng/vim-hybrid.git
git clone https://github.com/scrooloose/nerdtree.git
git clone https://github.com/airblade/vim-gitgutter.git
git clone https://github.com/itchyny/lightline.vim.git
git clone https://github.com/sheerun/vim-polyglot.git
git clone https://github.com/editorconfig/editorconfig-vim.git

