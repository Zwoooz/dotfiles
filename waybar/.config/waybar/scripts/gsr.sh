#!/bin/bash

PID_FILE="/tmp/gsr_recording.pid"

is_recording() {
  [ -f "$PID_FILE" ] && kill -0 "$(cat "$PID_FILE")" 2>/dev/null
}

show_status() {
  if is_recording; then
    echo '{"text":"REC","class":"recording","alt":"recording"}'
  else
    echo '{"text":"REC","class":"default","alt":"default"}'
  fi
}

case "$1" in
--status)
  show_status
  ;;
--toggle)
  if is_recording; then
    pkill -SIGRTMIN -f "^gpu-screen-recorder"
    rm -f "$PID_FILE"
    notify-send -t 2000 "⏹ Recording stopped"
  else
    pkill -SIGRTMIN -f "^gpu-screen-recorder"
    pgrep -f "^gpu-screen-recorder" >"$PID_FILE"
    notify-send -t 2000 "🔴 Recording started"
  fi
  show_status
  ;;
*)
  echo "Usage: $0 {--status|--toggle}"
  exit 1
  ;;
esac
