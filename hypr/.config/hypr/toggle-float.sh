#!/bin/bash
# Get current floating state before toggling
current_state=$(hyprctl activewindow | grep "floating:" | awk '{print $2}')

# Toggle floating
hyprctl dispatch togglefloating

# Only resize if we just made it floating (was 0, now should be 1)
if [ "$current_state" = "0" ]; then
  sleep 0.1
  hyprctl dispatch resizeactive exact 800 600
  hyprctl dispatch centerwindow
fi
