#!/bin/bash
current_state=$(hyprctl activewindow | grep "floating:" | awk '{print $2}')

hyprctl dispatch togglefloating

if [ "$current_state" = "0" ]; then
  sleep 0.1
  hyprctl dispatch resizeactive exact 800 600
  hyprctl dispatch centerwindow
fi
