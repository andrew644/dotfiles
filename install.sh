#! /bin/bash

function showHelp() {
    echo "Usage: $0 <option>" >&2
    echo "option: init, reload" >&2
    echo "init: First time setup. Loads everything." >&2
    echo "reload: Reload config. Can be run any number of times without issue." >&2

    exit 1
}

function setupLinks() {
	# Link config files
	###########################

	mkdir -p ~/.config/i3status
	mkdir -p ~/.config/i3
	ln -sf ~/dotfiles/config/i3status/config ~/.config/i3status/config
	ln -sf ~/dotfiles/config/i3/config ~/.config/i3/config

	mkdir -p ~/.config/nvim
	ln -sf ~/dotfiles/config/nvim/init.vim ~/.config/nvim/init.vim

	ln -sf ~/dotfiles/config/.xinitrc ~/.xinitrc

	ln -sf ~/dotfiles/config/zsh/.zprofile ~/.zprofile
	ln -sf ~/dotfiles/config/zsh/.zshrc ~/.zshrc

	mkdir -p ~/.config/termite
	ln -sf ~/dotfiles/config/termite/config ~/.config/termite/config

	mkdir -p ~/.config/compton
	ln -sf ~/dotfiles/config/compton/compton.conf ~/.config/compton/compton.conf
	ln -sf ~/dotfiles/config/compton/start.sh ~/.config/compton/start.sh

	mkdir -p ~/.config/polybar
	ln -sf ~/dotfiles/config/polybar/config ~/.config/polybar/config
	ln -sf ~/dotfiles/config/polybar/start.sh ~/.config/polybar/start.sh
}

function setupGit() {
	# Git config
	###########################

	git config --global user.name "andrew644"
	git config --global user.email andrew644@users.noreply.github.com
	git config --global push.default simple

}

function enableSsdTrim() {
	# requires util-linux
	systemctl enable --now fstrim.timer 
}

function installPackages() {
	sudo pacman -S util-linux
}

if [ -z "$1" ] || ( [ $1 != "init" ] && [ $1 != "reload" ] ); then
	showHelp
fi

option="$1"
set -x

setupLinks

if [ $option == "init" ]; then
	installPackages
	setupGit
	enableSsdTrim
fi
