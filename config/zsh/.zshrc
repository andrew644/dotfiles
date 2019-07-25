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

# Add scripts to path
export PATH=~/dotfiles/scripts:$PATH

# Add rust (cargo) to path
export PATH="$HOME/.cargo/bin:$PATH"

# Aliases
alias vim=nvim
alias vi=nvim
alias v=nvim

alias ls='ls --color=auto'
alias ll='ls -la --color=auto'
alias la='ls -la --color=auto'

# Set prompt
[ -f ~/dotfiles/config/zsh/.zshprompt.sh ] && source ~/dotfiles/config/zsh/.zshprompt.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
