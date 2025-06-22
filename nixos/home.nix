{ ... }:

{
	imports = [
		./zsh.nix
		./waybar.nix
		./swaylock.nix
		./wofi.nix
	];

	home.file.".config/hypr/hyprland.conf".source = ../hyprland/hyprland.conf;
	home.file.".xinitrc".source = ../x11/.xinitrc;
	home.file.".config/rofi/config.rasi".source = ../rofi/config.rasi;
	home.file.".config/i3/config".source = ../i3/config;
	home.file.".config/i3status/config".source = ../i3status/config;
	home.file.".config/picom/picom.conf".source = ../picom/picom.conf;
	home.file.".config/zathura/zathurarc".source = ../zathura/zathurarc;
	home.file.".config/mpv/mpv.conf".source = ../mpv/mpv.conf;

	#mime - file associations
	home.file.".config/mimeapps.list".source = ../mime/mimeapps.list;

	home.file.".local/share/applications/zathura.desktop".source = ../mime/desktop/zathura.desktop;
	home.file.".local/share/applications/mpv.desktop".source = ../mime/desktop/mpv.desktop;

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
		extraConfig = {
			push = {
				default = "simple";
				autoSetupRemote = true;
			};
			pull.rebase = true;
			init.defaultBranch = "main";
		};
	};

	programs.kitty =
	{
		enable = true;
		#theme = "PaperColor Dark";
		#theme = "Kanagawa";
		themeFile = "tokyo_night_moon";
		font.name = "Meslo";
	};

	home.sessionPath = ["$HOME/bin"];

	home.stateVersion = "24.05";

	programs.home-manager.enable = true;
}
