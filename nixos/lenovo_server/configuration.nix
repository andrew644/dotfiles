{ config, pkgs, ... }:

{
	imports =
		[ # Include the results of the hardware scan.
			./hardware-configuration.nix
			<home-manager/nixos>
		];

	# Bootloader.
	boot.loader.grub.enable = true;
	boot.loader.grub.device = "/dev/sda";
	boot.loader.grub.useOSProber = true;

	networking.hostName = "Lenovo_Server_1";

	#clear old generations
	nix.gc = {
		automatic = true;
		dates = "weekly";
		options = "--delete-older-than 30d";
	};

	# Enable networking
	networking.networkmanager.enable = true;

	# Set your time zone.
	time.timeZone = "America/New_York";

	# Select internationalisation properties.
	i18n.defaultLocale = "en_US.UTF-8";

	i18n.extraLocaleSettings = {
		LC_ADDRESS = "en_US.UTF-8";
		LC_IDENTIFICATION = "en_US.UTF-8";
		LC_MEASUREMENT = "en_US.UTF-8";
		LC_MONETARY = "en_US.UTF-8";
		LC_NAME = "en_US.UTF-8";
		LC_NUMERIC = "en_US.UTF-8";
		LC_PAPER = "en_US.UTF-8";
		LC_TELEPHONE = "en_US.UTF-8";
		LC_TIME = "en_US.UTF-8";
	};

	# Configure keymap in X11
	services.xserver.xkb = {
		layout = "us";
		variant = "";
	};

	# Enable sound with pipewire.
	services.pulseaudio.enable = false;
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
	};

	users.users.andrew = {
		isNormalUser = true;
		description = "Andrew";
		extraGroups = [
			"networkmanager"
			"wheel"
			"docker"
		];
		packages = with pkgs; [
			firefox
			neofetch
			fastfetch
			cmus #music
			veracrypt
			mpv #video player
			yt-dlp
			ffmpeg
			xfce.thunar # file manager
			zathura #pdf
		];
	};

	home-manager.users.andrew = {
		imports = [ ../home.nix ];
	};

	environment.systemPackages = with pkgs; [
		#WM tools
		rofi #app launcher
		arandr #gui xrandr
		xclip #clipboard support for vim
		i3lock #screen lock
		libnotify #send notifications with notify-send
		playerctl #control media and get metadata
		nitrogen #wallpaper manager for x11
		dunst #notifications
		feh # image viewer

		kitty #terminal
		yazi #file manager
		nomacs #image viewer

		#vesktop #discord app

		neovim
		neovim-remote
		git
		wget
		file
		ripgrep #faster grep
		fd #find alternative
		htop
		btop
		killall
		unzip

		#Dev
		gcc
		gnumake
		cmake
		meson #c++ build tool
		ninja #c++ build tool
		clang
		clang-tools
		scons
		gdb
		lldb_18
		bear # generate compile_commands.json for c++ autocomplete
		python3
		#texlive.combined.scheme-full #latex

		#Rust
		rustup
		#rustc
		#rust-analyzer
		#rustfmt
		#cargo

		#zig
		#zig

		#webdev
		#nodejs_22

		#gamedev
		#blender
		#libresprite

		#server
		docker-compose
	];
	
	virtualisation.docker = {
		enable = true;
		daemon.settings = {
			userland-proxy = false;
		};
	};
	
	services.tumbler.enable = true; # Thumbnail support for images in thunar
	
	services = {
		displayManager.sddm.enable = false;
		desktopManager.plasma6.enable = false;
		libinput.mouse.accelProfile = "flat";
		xserver = {
			enable = true;
			
			displayManager = {
				startx.enable = true;
				gdm.enable = false;
			};
			
			windowManager.i3 = {
				enable = true;
				package = pkgs.i3-gaps;
				extraPackages = with pkgs; [
					i3status
				];
			};
		};
	};
	
	services.openssh = {
		enable = true;
		PermitRootLogin = "no";
		PasswordAuthentication = false;
	};

	programs.zsh.enable = true;
	users.defaultUserShell = pkgs.zsh;
	
	fonts.packages = with pkgs; [
		nerd-fonts.hack
		nerd-fonts.meslo-lg
	];

	# Allow unfree packages
	nixpkgs.config.allowUnfree = true;

	system.stateVersion = "25.05"; # Did you read the comment?

}
