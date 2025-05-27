#!/bin/bash

INTERFACE=wlp3s0

# Show help message
show_help() {
  echo "Usage: sudo $0 [interface]"
  echo ""
  echo "Scans for 2.4 GHz Wi-Fi networks and recommends the least congested channel."
  echo ""
  echo "Arguments:"
  echo "  interface     Optional. Name of the wireless interface (default: wlp3s0)"
  echo ""
  echo "Example:"
  echo "  sudo $0 wlan0"
  exit 0
}

# Require root
if [[ $EUID -ne 0 ]]; then
  echo "Error: This script must be run with sudo or as root." >&2
  exit 1
fi

# Check for help flag
if [[ $1 == "-h" || $1 == "--help" ]]; then
  show_help
fi

# If interface is provided as argument, use it
if [[ -n "$1" && "$1" != "-"* ]]; then
  INTERFACE="$1"
fi

echo "[*] Scanning Wi-Fi networks on interface: $INTERFACE"

# Scan and get frequencies (MHz) of 2.4 GHz networks (2400-2500 MHz)
freqs=$(iw dev $INTERFACE scan | grep 'freq:' | awk '{print $2}' | grep '^24[0-9][0-9]$')

declare -A channel_count

# Map frequency to 2.4 GHz Wi-Fi channel
freq_to_channel() {
  case $1 in
    2412) echo 1 ;;
    2417) echo 2 ;;
    2422) echo 3 ;;
    2427) echo 4 ;;
    2432) echo 5 ;;
    2437) echo 6 ;;
    2442) echo 7 ;;
    2447) echo 8 ;;
    2452) echo 9 ;;
    2457) echo 10 ;;
    2462) echo 11 ;;
    2467) echo 12 ;;
    2472) echo 13 ;;
    *) echo 0 ;; # out of range or not 2.4GHz
  esac
}

# Count networks per channel
for f in $freqs; do
  ch=$(freq_to_channel $f)
  if [[ $ch -ne 0 ]]; then
    ((channel_count[$ch]++))
  fi
done

echo ""
echo "Detected networks per channel (2.4 GHz):"
for ch in {1..13}; do
  count=${channel_count[$ch]:-0}
  echo "  Channel $ch: $count networks"
done

# Find least congested channel
min_count=9999
best_channel=0
for ch in {1..13}; do
  count=${channel_count[$ch]:-0}
  if (( count < min_count )); then
    min_count=$count
    best_channel=$ch
  fi
done

echo ""
echo "[*] Recommended channel to use: $best_channel (with $min_count detected networks)"
