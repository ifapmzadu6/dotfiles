#! /bin/bash

cd ~/


# bash
ln -sf ~/dotfiles/.bash_profile ~/.bash_profile
ln -sf ~/dotfiles/.bashrc ~/.bashrc


# vim
mkdir ~/.vim
ln -sf ~/dotfiles/colors ~/.vim/colors
ln -sf ~/dotfiles/.vimrc ~/.vimrc

# install neobundle
curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh > install.sh
sh ./install.sh
rm install.sh

# git
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig

# install git-completion.bash
wget -nv https://raw.github.com/git/git/master/contrib/completion/git-completion.bash
mv -f git-completion.bash .git-completion.bash

# install git-prompt.sh
wget -nv https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh
mv -f git-prompt.sh .git-prompt.sh

