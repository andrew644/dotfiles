{ ... }:

{
	imports = [
		./zsh.nix
		./waybar.nix
		./swaylock.nix
		./wofi.nix
	];

	home.file.".config/hypr/hyprland.conf".source = ../hyprland/hyprland.conf;

	home.file.".config/nvim" = {
		source = ../nvim;
		recursive = true;
	};

	home.username = "andrew";
	home.homeDirectory = "/home/andrew";

	programs.git = {
		enable = true;
		userName = "andrew644";
		userEmail = "andrew644@users.noreply.github.com";
		#TODO Add push mode 
	};

	programs.kitty =
	{
		enable = true;
		#theme = "PaperColor Dark";
		theme = "Kanagawa";
		font.name = "Meslo";
	};

	home.stateVersion = "24.05";

	programs.home-manager.enable = true;
}
