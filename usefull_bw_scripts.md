limit_100k.sh:
```
#!/bin/bash

# Verifica que se haya pasado el nombre de la interfaz
if [[ -z "$1" ]]; then
    echo "❌ Error: Debes pasar el nombre de la interfaz como argumento."
    echo "👉 Uso: $0 <nombre_interfaz>"
    exit 1
fi

iface="$1"
bw="100kbit"

echo "🎯 Aplicando limitación de $bw a $iface..."

# Elimina cualquier configuración previa
sudo tc qdisc del dev "$iface" root 2>/dev/null

# Aplica la nueva limitación
sudo tc qdisc add dev "$iface" root tbf rate "$bw" latency 50ms burst 1540 && \
echo "✔️  Limitación aplicada correctamente a $iface." || \
echo "❌  Error al aplicar la limitación a $iface."
```
apply_bw.sh:

```
#!/bin/bash

# Lista de interfaces separadas por comas
interfaces="enp0s20u1,enp0s20u2,enp0s20u4,enp0s20u3u1,enp0s20u3u2,enp0s20u3u4"

# Valor del ancho de banda en kbit, pasado como argumento o definido por defecto
bw=${1:-10000}  # Si no se pasa argumento, usa 10000 kbit por defecto

# Convertir la lista de interfaces en un array
IFS=',' read -ra iface_array <<< "$interfaces"

for iface in "${iface_array[@]}"; do
    if [[ "$bw" -eq -1 ]]; then
        echo "🧹 Eliminando configuración de qdisc en $iface..."
        sudo tc qdisc del dev "$iface" root 2>/dev/null && \
        echo "✔️  Cola eliminada en $iface." || \
        echo "⚠️  No había cola en $iface o no se pudo eliminar."
    else
        echo "🎯 Aplicando limitación de $bw kbit a $iface..."
        sudo tc qdisc del dev "$iface" root 2>/dev/null
        sudo tc qdisc add dev "$iface" root tbf rate "${bw}kbit" latency 50ms burst 1540 && \
        echo "✔️  Limitación aplicada en $iface." || \
        echo "❌  Error al aplicar limitación en $iface."
    fi
done

```
