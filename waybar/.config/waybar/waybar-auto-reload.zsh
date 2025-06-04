#!/bin/zsh

ls "$HOME/.config/waybar/config.jsonc" | entr -d sh -c 'pkill -x -SIGUSR2 waybar' > /dev/null 2>&1

