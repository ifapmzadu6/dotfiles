# bash
export PATH=/usr/local/bin:$PATH

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
export GOROOT=/usr/local/opt/go/libexec
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

# golang plugin
set rtp+=$GOPATH/src/github.com/golang/lint/misc/vim


