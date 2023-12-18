{ ... }:

{
	programs.zsh = {
		autocd = true;
		shellAliases = {
			ls = "ls --color=auto";
			ll = "ls -la --color=auto";
			la = "ls -la --color=auto";
			vim = "nvim";
			vi = "nvim";
			v = "nvim";
		};
	};
}
