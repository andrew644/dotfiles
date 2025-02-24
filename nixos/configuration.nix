{ config, lib, pkgs, ... }:

{
	imports =
		[ # Include the results of the hardware scan.
			./sl3-hardware-configuration.nix
			<home-manager/nixos>
			./home.nix
		];

	# Bootloader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
	
	networking.hostName = "andrew_sl3"; # Define your hostname.
	# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
	
	# Configure network proxy if necessary
	# networking.proxy.default = "http://user:password@proxy:port/";
	# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
	
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
	
	# Enable the X11 windowing system.
	# You can disable this if you're only using the Wayland session.
	services.xserver.enable = true;
	
	# Enable the KDE Plasma Desktop Environment.
	services.displayManager.sddm.enable = true;
	services.desktopManager.plasma6.enable = true;
	
	# Configure keymap in X11
	services.xserver.xkb = {
		layout = "us";
		variant = "";
	};
	
	# Enable CUPS to print documents.
	services.printing.enable = true;
	
	# Enable sound with pipewire.
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
	
	# Enable touchpad support (enabled default in most desktopManager).
	# services.xserver.libinput.enable = true;
	
	# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.andrew = {
		isNormalUser = true;
		description = "Andrew";
		extraGroups = [ "networkmanager" "wheel" ];
		packages = with pkgs; [
			neofetch
			fastfetch
			spotify
			veracrypt
			mpv #video player
			yt-dlp
			ffmpeg
			calibre # ebook manager
			libreoffice
			zathura #pdf
			krita #art
			gimp #art
			inkscape-with-extensions #svg art
			obs-studio
		];
	};
	
	programs = {
		firefox.enable = true;
		zsh.enable = true;
	};
	users.defaultUserShell = pkgs.zsh;

	fonts.packages = with pkgs; [
		(nerdfonts.override { fonts = [ "Hack" "Meslo" ]; })
	];
	
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
		v4l-utils

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
	
	# Some programs need SUID wrappers, can be configured further or are
	# started in user sessions.
	# programs.mtr.enable = true;
	# programs.gnupg.agent = {
	#   enable = true;
	#   enableSSHSupport = true;
	# };
	
	# List services that you want to enable:
	
	# Enable the OpenSSH daemon.
	# services.openssh.enable = true;
	
	# Open ports in the firewall.
	# networking.firewall.allowedTCPPorts = [ ... ];
	# networking.firewall.allowedUDPPorts = [ ... ];
	# Or disable the firewall altogether.
	# networking.firewall.enable = false;
	
	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It‘s perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "24.11"; # Did you read the comment?

}
