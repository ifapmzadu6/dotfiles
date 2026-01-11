#!/bin/bash
set -e

set_git_config() {
    local key=$1
    local value=$2
    if ! git config --global --get ${key} > /dev/null; then
        git config --global ${key} "${value}"
    fi
}

# alias
set_git_config "alias.st" "status"
set_git_config "alias.co" "checkout"
set_git_config "alias.cm" "commit"
set_git_config "alias.br" "branch"
set_git_config "alias.cp" "cherry-pick"
set_git_config "alias.pl" "pull"
set_git_config "alias.l" "log --format='%C(yellow)%h %C(red) %cd %C(green) %cn  %Creset%s' --date=format:'%Y/%m/%d %H:%M:%S'"

# color.ui
set_git_config "color.ui" "auto"

# core.editor
set_git_config "core.editor" "vim"