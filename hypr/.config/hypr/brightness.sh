#!/bin/bash

CACHE_FILE="$HOME/.cache/ddcutil_buses"

# Usage function
usage() {
  echo "Usage: $0 <brightness> [options]"
  echo "   or: $0 [options] <brightness>"
  echo ""
  echo "Arguments:"
  echo "  brightness              Brightness value (0-100)"
  echo ""
  echo "Options:"
  echo "  -b, --bus <buses>       Comma-separated bus numbers (e.g., 3,4,5)"
  echo "  -n, --no-cache          Bypass cache and auto-detect displays"
  echo "  -r, --refresh-cache     Detect buses and update cache"
  echo "  -h, --help              Show this help message"
  echo ""
  echo "Examples:"
  echo "  $0 50                   # Use cached/detected buses"
  echo "  $0 100 -b 3,4,5         # Use specific buses"
  echo "  $0 100 -b 3,4,5 -r      # Use specific buses AND cache the specified buses"
  echo "  $0 -b 3,4,5 100         # Options can come before brightness"
  echo "  $0 10 --no-cache        # Auto-detect without using cache"
  echo "  $0 75 --refresh-cache   # Detect buses and update cache"
}

# Parse all arguments
brightness=""
buses_arg=""
mode="bus"
refresh_cache=false

while [[ $# -gt 0 ]]; do
  case $1 in
  -b | --bus)
    if [[ -z "$2" ]] || [[ "$2" == -* ]]; then
      echo "Error: -b/--bus requires a bus list argument"
      usage
      exit 1
    fi
    buses_arg="$2"
    shift 2
    ;;
  -n | --no-cache)
    mode="no-cache"
    shift
    ;;
  -r | --refresh-cache)
    refresh_cache=true
    shift
    ;;
  -h | --help)
    usage
    exit 0
    ;;
  -*)
    echo "Error: Unknown option '$1'"
    usage
    exit 1
    ;;
  *)
    # If it's a number, treat it as brightness
    if [[ "$1" =~ ^[0-9]+$ ]]; then
      if [[ -z "$brightness" ]]; then
        brightness="$1"
        shift
      else
        echo "Error: Multiple brightness values provided"
        exit 1
      fi
    else
      echo "Error: Invalid argument '$1'"
      usage
      exit 1
    fi
    ;;
  esac
done

# Check if brightness was provided
if [[ -z "$brightness" ]]; then
  echo "Error: Brightness value is required"
  usage
  exit 1
fi

# Validate brightness
if [[ "$brightness" -lt 0 ]] || [[ "$brightness" -gt 100 ]]; then
  echo "Error: Brightness must be between 0 and 100"
  exit 1
fi

if [[ $mode == "no-cache" ]]; then
  # Auto-detect buses and use them without caching
  echo "Detecting monitors..."

  # Detect buses and their display info
  buses=()
  display_info=()

  # Parse ddcutil output to get bus and model pairs
  current_bus=""
  while IFS= read -r line; do
    # Match "I2C bus: /dev/i2c-X"
    if [[ $line =~ I2C\ bus:.*i2c-([0-9]+) ]]; then
      current_bus="${BASH_REMATCH[1]}"
    fi

    # Match "Model: XXXXX" and save the pair
    if [[ $line =~ Model:[[:space:]]+(.+) ]]; then
      if [[ -n "$current_bus" ]]; then
        buses+=("$current_bus")
        display_info+=("${BASH_REMATCH[1]}")
        current_bus=""
      fi
    fi
  done < <(ddcutil detect 2>/dev/null)

  if [[ ${#buses[@]} -eq 0 ]]; then
    echo "Error: No displays detected"
    exit 1
  fi

  # Output found displays
  echo "Found ${#buses[@]} display(s):"
  for i in "${!buses[@]}"; do
    echo "  Display $((i + 1)): Bus ${buses[$i]} - ${display_info[$i]:-Unknown}"
  done

  echo "Setting brightness to ${brightness}%..."

  # Set brightness for all detected buses
  for bus in "${buses[@]}"; do
    ddcutil --bus "$bus" --sleep-multiplier 0.1 --noverify setvcp 10 "$brightness" &>/dev/null &
  done
  wait
  exit 0
else
  # Bus mode with caching
  # Determine which buses to use
  if [[ -n "$buses_arg" ]]; then
    # Use provided buses
    IFS=',' read -ra buses <<<"$buses_arg"
    echo "Using specified buses: ${buses[*]}"

    # Only cache if refresh-cache flag is set
    if [[ "$refresh_cache" == true ]]; then
      mkdir -p "$(dirname "$CACHE_FILE")"
      echo "$buses_arg" >"$CACHE_FILE"
      echo "Cached buses: ${buses[*]}"
    fi
  elif [[ "$refresh_cache" == true ]] || [[ ! -f "$CACHE_FILE" ]]; then
    # Detect and cache buses (either forced refresh or no cache exists)
    if [[ ! -f "$CACHE_FILE" ]]; then
      echo "No cache file found."
    fi
    echo "Detecting monitors and caching bus numbers..."

    # Detect buses and their display info
    buses=()
    display_info=()

    # Parse ddcutil output to get bus and model pairs
    current_bus=""
    while IFS= read -r line; do
      # Match "I2C bus: /dev/i2c-X"
      if [[ $line =~ I2C\ bus:.*i2c-([0-9]+) ]]; then
        current_bus="${BASH_REMATCH[1]}"
      fi

      # Match "Model: XXXXX" and save the pair
      if [[ $line =~ Model:[[:space:]]+(.+) ]]; then
        if [[ -n "$current_bus" ]]; then
          buses+=("$current_bus")
          display_info+=("${BASH_REMATCH[1]}")
          current_bus=""
        fi
      fi
    done < <(ddcutil detect 2>/dev/null)

    if [[ ${#buses[@]} -eq 0 ]]; then
      echo "Error: No displays detected"
      exit 1
    fi

    # Output found displays
    echo "Found ${#buses[@]} display(s):"
    for i in "${!buses[@]}"; do
      echo "  Display $((i + 1)): Bus ${buses[$i]} - ${display_info[$i]:-Unknown}"
    done

    # Cache detected buses
    mkdir -p "$(dirname "$CACHE_FILE")"
    IFS=',' eval 'echo "${buses[*]}"' >"$CACHE_FILE"
    echo "Cached buses: ${buses[*]}"
  else
    # Use cached buses
    IFS=',' read -ra buses <<<"$(cat "$CACHE_FILE")"
    echo "Using cached buses: ${buses[*]}"
  fi

  echo "Setting brightness to ${brightness}%..."

  # Set brightness for all buses in parallel
  for bus in "${buses[@]}"; do
    ddcutil --bus "$bus" --sleep-multiplier 0.1 --noverify setvcp 10 "$brightness" &>/dev/null &
  done
  wait
fi
