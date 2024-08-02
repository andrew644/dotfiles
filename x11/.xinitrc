#!/usr/bin/env bash

. ~/dotfiles/scripts/set_resolution.sh

picom &

exec awesome
