{ config, lib, pkgs, ... }:

{
	imports = [
		./hardware-configuration.nix
		<home-manager/nixos>
	];

	# Bootloader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	boot.supportedFilesystems = [ "ntfs" ];

	networking.hostName = "andrew_desktop"; # Define your hostname.
	#networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

	# Enable networking
	networking.networkmanager.enable = true;

	#clear old generations
	nix.gc = {
		automatic = true;
		dates = "weekly";
		options = "--delete-older-than 30d";
	};

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

	# Enable sound with pipewire.
	sound.enable = true;
	hardware.pulseaudio.enable = false;
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
		# If you want to use JACK applications, uncomment this
		#jack.enable = true;

		# use the example session manager (no others are packaged yet so this is enabled by default,
		# no need to redefine it in your config for now)
		#media-session.enable = true;
	};

	# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.andrew = {
		isNormalUser = true;
		description = "Andrew";
		extraGroups = [ "networkmanager" "wheel" ];
		packages = with pkgs; [
			firefox
			neofetch
			fastfetch
			spotify
			sptlrx #spotify lyrics in terminal
			veracrypt
			mpv #video player
			yt-dlp
			ffmpeg
			protonplus
			xfce.thunar # file manager
			calibre # ebook manager
			libreoffice
			zathura #pdf
			krita #art
			gimp #art
			inkscape-with-extensions #svg art
			obs-studio
		];
	};

	programs.steam.enable = true;

	home-manager.users.andrew = {
		imports = [ ./home.nix ];
	};

	# Allow unfree packages
	nixpkgs.config.allowUnfree = true;

	# List packages installed in system profile. To search, run:
	# $ nix search wget
	environment.systemPackages = with pkgs; [
		#WM tools
		rofi #app launcher
		arandr #gui xrandr
		xclip #clipboard support for vim
		i3lock #screen lock
		libnotify #send notifications with notify-send
		playerctl #control media and get metadata
		picom
		nitrogen #wallpaper manager for x11
		dunst #notifications
		feh # image viewer

		kitty #terminal
		yazi #file manager
		nomacs #image viewer

		vesktop #discord app

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
		godot_4
		bear # generate compile_commands.json for c++ autocomplete
		python3
		texlive.combined.scheme-full #latex

		#Rust
		rustc
		rust-analyzer
		cargo

		#webdev
		nodejs_22
	];


	services = {
		displayManager.sddm.enable = false;
		desktopManager.plasma6.enable = false;
		libinput.mouse.accelProfile = "flat";
		xserver = {
			enable = true;

			videoDrivers = [ "nvidia" ];

			displayManager.startx.enable = true;

			windowManager.awesome = {
				enable = false;
				luaModules = with pkgs.luaPackages; [
					luarocks # package manager for lua
					luadbi-mysql
				];
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

	programs.zsh.enable = true;
	users.defaultUserShell = pkgs.zsh;

	fonts.packages = with pkgs; [
		(nerdfonts.override { fonts = [ "Hack" "Meslo" ]; })
	];

	#Nvidia
	hardware.opengl.enable = true;


	hardware.nvidia = {
		modesetting.enable = true;
		powerManagement.enable = false;
		powerManagement.finegrained = false;
		open = false;
		nvidiaSettings = true;
		package = config.boot.kernelPackages.nvidiaPackages.stable;
	};

	system.stateVersion = "24.05"; # Did you read the comment?
}
