#! /bin/bash

# Link config files
###########################

mkdir -p ~/.config/nvim
ln -sf ~/dotfiles/nvim/init.vim ~/.config/nvim/init.vim

ln -sf ~/dotfiles/zsh/.zshrc ~/.zshrc
