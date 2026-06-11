#!/bin/bash

# kill waypaper gui
pkill -x waypaper

# grab the passed wallpaper argument
wallpaper=$1

# wait a bit for animation of swww
sleep 2

# run pywal
wal -n -q -i "$wallpaper" --cols16 dual

# restart dunst
systemctl --user restart dunst.service

# trigger waybar css update
sed -i "s/WAL_REFRESH: .*/WAL_REFRESH: $(date) *\//" ~/.config/waybar/style.css

#update spotify
spicetify apply

# update firefox and thunderbird
pywalfox update

# generate GTK theme
bash ~/oomox/plugins/theme_oomox/change_color.sh ~/.cache/wal/colors-oomox -o wal

matugen image "$wallpaper"

# restart ncspot
pkill -x ncspot
