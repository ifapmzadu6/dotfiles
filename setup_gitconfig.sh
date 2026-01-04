#!/bin/bash
set -e

# alias.st
if ! git config --global --get alias.st > /dev/null; then
    git config --global alias.st status
fi

# alias.co
if ! git config --global --get alias.co > /dev/null; then
    git config --global alias.co checkout
fi

# alias.cm
if ! git config --global --get alias.cm > /dev/null; then
    git config --global alias.cm commit
fi

# alias.br
if ! git config --global --get alias.br > /dev/null; then
    git config --global alias.br branch
fi

# alias.cp
if ! git config --global --get alias.cp > /dev/null; then
    git config --global alias.cp cherry-pick
fi

# alias.pl
if ! git config --global --get alias.pl > /dev/null; then
    git config --global alias.pl pull
fi

# alias.l
if ! git config --global --get alias.l > /dev/null; then
    git config --global alias.l "log --format='%C(yellow)%h %C(red) %cd %C(green) %cn  %Creset%s' --date=format:'%Y/%m/%d %H:%M:%S'"
fi

# color.ui
if ! git config --global --get color.ui > /dev/null; then
    git config --global color.ui auto
fi

# core.editor
if ! git config --global --get core.editor > /dev/null; then
    git config --global core.editor vim
fi
