#!/bin/bash

# gitconfig
git config --global color.diff auto
git config --global color.status auto
git config --global color.branch auto
git config --global color.interactive auto
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.cm commit
git config --global alias.br branch
git config --global alias.l "log --format='%C(yellow)%H  %C(red) %cd  %C(green) %cn  %Creset%s'"
git config --global core.editor "vim -c 'set fenc=utf-8'"
git lfs install

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
git clone https://github.com/justinmk/vim-syntax-extra.git

