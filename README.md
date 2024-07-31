
# first time setup
# install home-manager
nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz home-manager
nix-channel --update

rm .nix files in /etc/nixos
ln -s ~/dotfiles/nixos/configuration.nix /etc/nixos/configuration.nix
ln -s ~/dotfiles/nixos/hardware-configuration.nix /etc/nixos/hardware-configuration.nix

# update system with new config changes
sudo nixos-rebuild switch

# temporary install of a program
nix-shell -p sqlite

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
