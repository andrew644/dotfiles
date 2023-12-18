{ ... }:

{
	programs.zsh = {
		autocd = true;
		enableAutosuggestions = true;
		enableCompletion = true;
		syntaxHighlighting.enable = true;
		shellAliases = {
			ls = "ls --color=auto";
			ll = "ls -la --color=auto";
			la = "ls -la --color=auto";
			vim = "nvim";
			vi = "nvim";
			v = "nvim";
		};
		initExtra = ''
ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$fg[blue]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}*%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# show git branch/tag, or name-rev if on detached head
parse_git_branch() {
  (command git for-each-ref --format='%(objectname) %(refname:short)' refs/heads | awk "/^$(git rev-parse HEAD)/ {print \$2}") 2>/dev/null
}

# show red star if there are uncommitted changes
parse_git_dirty() {
  if command git diff-index --quiet HEAD 2> /dev/null; then
    echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
  else
    echo "$ZSH_THEME_GIT_PROMPT_DIRTY"
  fi
}

git_custom_status() {
  local git_where="$(parse_git_branch)"
  [ -n "$git_where" ] && echo "$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_PREFIX$(parse_git_branch)$ZSH_THEME_GIT_PROMPT_SUFFIX"
}
RPS1='$(git_custom_status) $EPS1'

setopt PROMPT_SUBST
PROMPT='%K{magenta}$(printf " %.0s" $(seq 1 $(tput cols)))%k
%F{red}%(?,,X%? )%f%T  %F{blue}%~%f  
λ '
		'';
	};
}
