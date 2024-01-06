#!/bin/bash

# alias.st
git config alias.st > /dev/null
if [ $? != 0 ]; then
    git config --global alias.st status
fi

# alias.co
git config alias.co > /dev/null
if [ $? != 0 ]; then
    git config --global alias.co checkout
fi

# alias.cm
git config alias.cm > /dev/null
if [ $? != 0 ]; then
    git config --global alias.cm commit
fi

# alias.br
git config alias.br > /dev/null
if [ $? != 0 ]; then
    git config --global alias.br branch
fi

# alias.cp
git config alias.cp > /dev/null
if [ $? != 0 ]; then
    git config --global alias.cp cherry-pick
fi

# alias.pl
git config alias.pl > /dev/null
if [ $? != 0 ]; then
    git config --global alias.pl pull
fi

# alias.l
git config alias.l > /dev/null
if [ $? != 0 ]; then
    git config --global alias.l "log --format='%C(yellow)%h %C(red) %cd %C(green) %cn  %Creset%s' --date=format:'%Y/%m/%d %H:%M:%S'"
fi

# color.ui
git config color.ui > /dev/null
if [ $? != 0 ]; then
    git config --global color.ui auto
fi

# core.editor
git config core.editor > /dev/null
if [ $? != 0 ]; then
    git config --global core.editor vim
fi

