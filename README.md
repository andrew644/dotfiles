
# first time setup
# install home-manager
nix-shell -p git neovim
git clone ...
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz home-manager
sudo nix-channel --update

sudo rm /etc/nixos/configuration.nix
sudo rm /etc/nixos/hardware-configuration.nix
sudo ln -s ~/dotfiles/nixos/configuration.nix /etc/nixos/configuration.nix
sudo ln -s ~/dotfiles/nixos/hardware-configuration.nix /etc/nixos/hardware-configuration.nix

# update system with new config changes
sudo nixos-rebuild switch


# update git remote to ssh
git remote set-url origin git@github.com:andrew644/dotfiles.git

# make ssh key
ssh-keygen -t ed25519 -C "github@aishearer.com"

# start hyprland
Hyprland

# exit hyprland
hyprctl dispatch exit



# Mounting
# see drives
lsblk

sudo mount /dev/sda1 ~/mount/usb

# NTFS file systems
sudo mount -t ntfs-3g /dev/sdb1 ~/mount/usb


# file command
file ./path/to/binary

output will tell info about file and if it has debug symbols

# Audio
wpctl status
wpctl set-default 60


# Get color codes for zsh
for code in {000..255}; do print -P -- "$code: %F{$code}Color%f"; done

# File associations
you may need to run
update-desktop-database ~/.local/share/applications/ 

# Wifi
Use iwctl
