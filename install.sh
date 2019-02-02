#!/bin/bash

# gitconfig
unlink ~/.gitconfig
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig

# vimrc
unlink ~/.vimrc
ln -sf ~/dotfiles/.vimrc ~/.vimrc

# vim plugin
rm -rf ~/.vim
mkdir -p ~/.vim/pack/mypackage/start
cd ~/.vim/pack/mypackage/start
git clone https://github.com/w0ng/vim-hybrid.git
git clone https://github.com/scrooloose/nerdtree.git
git clone https://github.com/tpope/vim-fugitive.git
git clone https://github.com/airblade/vim-gitgutter.git
git clone https://github.com/itchyny/lightline.vim.git

