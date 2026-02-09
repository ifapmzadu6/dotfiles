# Completion settings
autoload -Uz compinit
compinit

# Case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'

# Show all candidates on first Tab if ambiguous
setopt auto_menu

# Incremental history search (Up/Down arrow keys)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# Disable audible bell
setopt no_beep
