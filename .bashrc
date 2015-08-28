
# bash
export PATH=/usr/local/bin:$PATH

# if mac
if [ "$(uname)" == 'Darwin' ]; then
    # set current directory to window title
    case $TERM in
        xterm*)
            PS1="\[\033]0;\u@\h: \w\007\]bash\\$ "
            ;;
        *)
            PS1="bash\\$ "
            ;;
    esac
    # set current directory to tab title
    PROMPT_COMMAND='echo -ne "\033]0;${PWD/#${HOME}/~}\007"'
fi

if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi


# git
source ~/.git-prompt.sh
source ~/.git-completion.bash
GIT_PROMPT_ONLY_IN_REPO=true
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUPSTREAM=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWSTASHSTATE=1\true
export PS1='\[\033[1;32m\]\u\[\033[00m\]:\[\033[1;34m\]\w\[\033[1;33m\]$(__git_ps1)\[\033[1;32m\] \$ \[\033[00m\]'

# golang
export GOROOT=/usr/local/go
export GOPATH=$HOME/.go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin 

