#!/bin/bash

default=$(pacmd list-sinks simple | grep "index:" | grep -v "*" | cut -d ":" -f 2)
~/dotfiles/scripts/pa-move-sink-input.sh $default
