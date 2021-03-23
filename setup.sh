#!/bin/bash

# git .gitconfig
if [ ! "git config --list --name-only | grep alias.st" ]; then
    git config --global alias.st status
    echo "git config --global alias.st status"
fi
if [ ! "git config --list --name-only | grep alias.co" ]; then
    git config --global alias.co checkout
    echo "git config --global alias.co checkout"
fi
if [ ! "git config --list --name-only | grep alias.cm" ]; then
    git config --global alias.cm commit
    echo "git config --global alias.cm commit"
fi
if [ ! "git config --list --name-only | grep alias.br" ]; then
    git config --global alias.br branch
    echo "git config --global alias.br branch"
fi
if [ ! "git config --list --name-only | grep alias.cp" ]; then
    git config --global alias.cp cherry-pick
    echo "git config --global alias.cp cherry-pick"
fi
if [ ! "git config --list --name-only | grep alias.pl" ]; then
    git config --global alias.pl pull
    echo "git config --global alias.pl pull"
fi
if [ ! "git config --list --name-only | grep alias.l" ]; then
    git config --global alias.l "log --format='%C(yellow)%h %C(red) %cd %C(green) %cn  %Creset%s' --date=format:'%Y/%m/%d %H:%M:%S'"
    echo "git config --global alias.l \"log --format='%C(yellow)%h %C(red) %cd %C(green) %cn  %Creset%s' --date=format:'%Y/%m/%d %H:%M:%S'\""
fi
if [ ! "git config --list --name-only | grep color.ui" ]; then
    git config --global color.ui auto
    echo "git config --global color.ui auto"
fi
if [ ! "git config --list --name-only | grep core.editor" ]; then
    git config --global core.editor vim
    echo "git config --global core.editor vim"
fi
if [ ! "git config --list --name-only | grep pull.rebase" ]; then
    git config --global pull.rebase true
    echo "git config --global pull.rebase true"
fi

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

