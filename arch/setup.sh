#!/usr/bin/env bash

#one time setup commands

#set shell to zsh
chsh -s $(which zsh)

#install typescript language-server
sudo npm install -g @vtsls/language-server

#link config
ln -sf ~/dotfiles/zsh/.zshrc ~/.zshrc

mkdir -p ~/.config/kitty
ln -sf ~/dotfiles/kitty/kitty.conf ~/.config/kitty/kitty.conf
ln -sf ~/dotfiles/kitty/current-theme.conf ~/.config/kitty/current-theme.conf

mkdir -p ~/.config/niri
ln -sf ~/dotfiles/niri/config.kdl ~/.config/niri/config.kdl


#git
git config --global user.name "andrew644"
git config --global user.email "andrew644@users.noreply.github.com"
git config --global push.default simple
git config --global init.defaultBranch main
