{ ... }:

{
	imports = [
		./zsh.nix
		./waybar.nix
		#./hyprland.nix
	];
	home.username = "andrew";
	home.homeDirectory = "/home/andrew";

	programs.git = {
		enable = true;
		userName = "andrew644";
		userEmail = "andrew644@users.noreply.github.com";
		#TODO Add push mode 
	};

	programs.zsh = {
		enable = true;
	};

	programs.kitty =
	{
		enable = true;
		theme = "PaperColor Dark";
		font.name = "Meslo";
	};

	home.stateVersion = "23.11";

	programs.home-manager.enable = true;
}
