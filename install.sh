#! /bin/bash

# move Home Directory
cd ~

# bash
unlink ~/.bash_profile
ln -sf ~/dotfiles/.bash_profile ~/.bash_profile
unlink ~/.bashrc
ln -sf ~/dotfiles/.bashrc ~/.bashrc

# git
unlink ~/.gitconfig
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig

# remove neobundle
rm -rf ~/.vim

# install neobundle
curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh > install.sh
sh ./install.sh
rm install.sh

# install git-completion.bash
wget -nv https://raw.github.com/git/git/master/contrib/completion/git-completion.bash
mv -f git-completion.bash .git-completion.bash

# install git-prompt.sh
wget -nv https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh
mv -f git-prompt.sh .git-prompt.sh

# vim
unlink ~/.vimrc
ln -sf ~/dotfiles/.vimrc ~/.vimrc

