#!/bin/bash

logfile="$HOME/.cache/sunshine-workaround.log"

status=$(systemctl --user is-active sunshine.service)

if [[ "$status" != "active" ]]; then
  systemctl --user start sunshine.service
  echo "$(date): Starting sunshine..." >>"$logfile"

else
  echo "$(date): Sunshine already running." >>"$logfile"
fi
