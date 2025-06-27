#!/bin/sh

# Función para mostrar estado de servicios
show_status() {
  clear
  echo "Estado de los servicios:"
  echo "------------------------"
  echo "Samba (smbd):"
  if systemctl is-active --quiet smbd; then
    systemctl status smbd --no-pager
  else
    echo "smbd no está activo"
  fi
  echo
  echo "NFS (nfs-server):"
  if systemctl is-active --quiet nfs-server; then
    systemctl status nfs-server --no-pager
  else
    echo "nfs-server no está activo"
  fi
  echo
  read -r -p "Presiona Enter para volver al menú..."
}

# Función para activar servicios
enable_service() {
  echo "Activando servicios SMB y NFS..."
  systemctl enable smbd nfs-server
  systemctl start smbd nfs-server
  echo "Servicios activados."
  read -r -p "Presiona Enter para continuar..."
}

# Función para desactivar servicios
disable_service() {
  echo "Desactivando servicios SMB y NFS..."
  systemctl stop smbd nfs-server
  systemctl disable smbd nfs-server
  echo "Servicios desactivados."
  read -r -p "Presiona Enter para continuar..."
}

# Menú principal
while true; do
  clear
  echo "=== Administración de SMB y NFS ==="
  echo "1) Estado de servicios"
  echo "2) Activar servicios"
  echo "3) Desactivar servicios"
  echo "4) Salir"
  echo
  printf "Elige una opción: "
  read -r opcion

  case "$opcion" in
    1) show_status ;;
    2) enable_service ;;
    3) disable_service ;;
    4) echo "Saliendo..."; exit 0 ;;
    *) echo "Opción inválida. Presiona Enter para intentar de nuevo."; read -r ;;
  esac
done
