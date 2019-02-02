#!/bin/bash

# move Home Directory
cd ~

# git
unlink ~/.gitconfig
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig

# vim
unlink ~/.vimrc
ln -sf ~/dotfiles/.vimrc ~/.vimrc

# vim
rm -rf ~/.vim
mkdir -p ~/.vim/pack/mypackage/start
cd ~/.vim/pack/mypackage/start

# vim plugin
git clone https://github.com/w0ng/vim-hybrid.git
git clone https://github.com/scrooloose/nerdtree.git
git clone https://github.com/tpope/vim-fugitive.git
git clone https://github.com/airblade/vim-gitgutter.git
git clone https://github.com/itchyny/lightline.vim.git

