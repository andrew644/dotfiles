#!/usr/bin/env bash

#link config
ln -sf ~/dotfiles/zsh/zshrc ~/.zshrc

mkdir -p ~/.config/kitty
ln -sf ~/dotfiles/kitty/kitty.conf ~/.config/kitty/kitty.conf
ln -sf ~/dotfiles/kitty/current-theme.conf ~/.config/kitty/current-theme.conf

mkdir -p ~/.config/niri
ln -sf ~/dotfiles/niri/config.kdl ~/.config/niri/config.kdl

mkdir -p ~/.config/noctalia
ln -sf ~/dotfiles/noctalia/colors.json ~/.config/noctalia/colors.json
ln -sf ~/dotfiles/noctalia/settings.json ~/.config/noctalia/settings.json

sudo mkdir -p /etc/pacman.d/hooks
sudo ln -sf ~/dotfiles/arch/andrew_pacman_install.hook /etc/pacman.d/hooks/andrew_pacman_install.hook

sudo mkdir -p /etc/NetworkManager/conf.d
sudo ln -sf ~/dotfiles/arch/wifi_backend.conf /etc/NetworkManager/conf.d/wifi_backend.conf

mkdir -p ~/.config/nvim/lua/andrew
ln -sf ~/dotfiles/nvim/init.lua ~/.config/nvim/init.lua
ln -sf ~/dotfiles/nvim/lua/andrew/plugins.lua ~/.config/nvim/lua/andrew/plugins.lua
ln -sf ~/dotfiles/nvim/lua/andrew/lualine.lua ~/.config/nvim/lua/andrew/lualine.lua

#mkdir -p ~/.emacs.d
#ln -sf ~/dotfiles/emacs/init.el ~/.emacs.d/init.el
