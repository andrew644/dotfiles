# History settings
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt sharehistory
setopt incappendhistory

# type name of directory to cd into it
setopt autocd

# For using output of commands in prompt
setopt PROMPT_SUBST

bindkey -v
bindkey '^R' history-incremental-search-backward

# Use home and end keys to jump to the beginning and end of line
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line

# Autocomplere commands
zstyle :compinstall filename '/home/andrew/.zshrc'
autoload -Uz compinit
compinit

# Aliases
alias vim=nvim
alias vi=nvim
alias v=nvim

alias ls='ls --color=auto'
alias ll='ls -la --color=auto'
alias la='ls -la --color=auto'

alias pdf=zathura

alias shutdown='sudo shutdown -h now'
alias reboot='sudo shutdown -r now'
alias restart='sudo shutdown -r now'

# Set prompt
[ -f ~/dotfiles/zsh/.zshprompt.sh ] && source ~/dotfiles/zsh/.zshprompt.sh

export PATH=$PATH:~/bin/zig
