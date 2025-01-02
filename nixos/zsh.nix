{ ... }:

{
	programs.zsh = {
		enable = true;
		autocd = true;
		autosuggestion.enable = true;
		enableCompletion = true;
		syntaxHighlighting.enable = true;
		shellAliases = {
			ls = "ls --color=auto";
			ll = "ls -lah --color=auto";
			la = "ls -lah --color=auto";

			e = "yazi";
			i = "nomacs";
			pdf = "zathura";

			vim = "nvim";
			vi = "nvim";
			v = "nvim";

			shutdown = "sudo shutdown -h now";
			reboot = "sudo shutdown -r now";
			restart = "sudo shutdown -r now";

			switch = "sudo nixos-rebuild switch";

			mountwin = "sudo ntfs-3g /dev/nvme0n1p3 ~/mount/windows";
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
PROMPT='%K{8}$(printf " %.0s" $(seq 1 $(tput cols)))%k
%F{red}%(?,,X%? )%f%T  %F{blue}%~%f  
λ '
		'';
	};
}
