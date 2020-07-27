#!/bin/bash
cd `dirname $0`

# update
git pull

# git .gitconfig
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.cm commit
git config --global alias.br branch
git config --global alias.cp cherry-pick
git config --global alias.l "log --format='%C(yellow)%H  %C(red) %cd  %C(green) %cn  %Creset%s'"
git config --global color.ui auto
git config --global core.editor "vim -c 'set fenc=utf-8'"

# vim .vimrc
unlink ~/.vimrc
ln -sf $(pwd)/vimrc ~/.vimrc
# vim plugins
rm -rf ~/.vim
mkdir -p ~/.vim/pack/mypackage/start
cd ~/.vim/pack/mypackage/start
git clone https://github.com/w0ng/vim-hybrid.git
git clone https://github.com/scrooloose/nerdtree.git
git clone https://github.com/airblade/vim-gitgutter.git
git clone https://github.com/itchyny/lightline.vim.git
git clone https://github.com/sheerun/vim-polyglot.git
git clone https://github.com/editorconfig/editorconfig-vim.git

