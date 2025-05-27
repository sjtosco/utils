#!/bin/bash

INTERFACE=wlp3s0

echo "[*] Escaneando redes Wi-Fi en $INTERFACE..."

# Escanea y obtiene frecuencias (MHz) de redes detectadas en 2.4 GHz (2400-2500 MHz)
freqs=$(sudo iw dev $INTERFACE scan | grep 'freq:' | awk '{print $2}' | grep '^24[0-9][0-9]$')

declare -A channel_count

# Mapea frecuencia a canal 2.4 GHz
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
    *) echo 0 ;; # fuera de rango o no 2.4GHz
  esac
}

# Cuenta redes por canal
for f in $freqs; do
  ch=$(freq_to_channel $f)
  if [[ $ch -ne 0 ]]; then
    ((channel_count[$ch]++))
  fi
done

echo "Redes detectadas por canal (2.4 GHz):"
for ch in {1..13}; do
  count=${channel_count[$ch]:-0}
  echo "Canal $ch: $count redes"
done

# Encuentra canal con menos redes
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
echo "[*] Canal recomendado para usar: $best_channel (con $min_count redes detectadas)"
