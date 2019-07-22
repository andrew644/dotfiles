HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt sharehistory
setopt incappendhistory
setopt autocd
setopt PROMPT_SUBST # For using output of commands in prompt
bindkey -v
bindkey '^R' history-incremental-search-backward
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

# Set prompt
[ -f ~/.config/zsh/.zshprompt.sh ] && source ~/.config/zsh/.zshprompt.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
