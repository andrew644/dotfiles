#!/usr/bin/env bash

#one time setup commands

#set shell to zsh
chsh -s $(which zsh)

#install typescript language-server
sudo npm install -g @vtsls/language-server

#git
git config --global user.name "andrew644"
git config --global user.email "andrew644@users.noreply.github.com"
git config --global push.default simple
git config --global init.defaultBranch main

. ~/dotfiles/arch/link.sh
