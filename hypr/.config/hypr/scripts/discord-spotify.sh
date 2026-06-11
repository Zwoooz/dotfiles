#!/bin/bash

ELECTRON_OZONE_PLATFORM_HINT= discord &
sleep 7
# spotify &
kitty --class ncspot -e bash -c "while true; do ncspot || break; done" &
