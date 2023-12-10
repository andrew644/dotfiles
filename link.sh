#!/usr/bin/env bash

# Link config files
###########################

mkdir -p ~/.config/nvim/lua/andrew/lsp
ln -sf ~/dotfiles/nvim/*.lua ~/.config/nvim/
ln -sf ~/dotfiles/nvim/lua/andrew/*.lua ~/.config/nvim/lua/andrew
ln -sf ~/dotfiles/nvim/lua/andrew/lsp/*.lua ~/.config/nvim/lua/andrew/lsp

ln -sf ~/dotfiles/zsh/.zshrc ~/.zshrc
