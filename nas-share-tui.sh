#!/bin/bash

CONFIG_DIR="/etc/samba/smb.conf.d"
SMB_CONF_MAIN="/etc/samba/smb.conf"
NFS_EXPORTS="/etc/exports"

show_help() {
    echo "Uso: nas-share-tui [opción]"
    echo
    echo "Opciones:"
    echo "  -h, --help      Mostrar esta ayuda"
    echo
    echo "Sin argumentos se inicia el menú interactivo para administrar shares SMB y NFS."
    exit 0
}

# Mostrar ayuda si se pasa -h o --help
if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    show_help
fi

# Asegura directorios y configuración básica
init_config() {
    mkdir -p "$CONFIG_DIR"
    grep -q "$CONFIG_DIR" "$SMB_CONF_MAIN" || echo "include = $CONFIG_DIR/*.conf" >> "$SMB_CONF_MAIN"
}

# Selección de editor
choose_editor() {
    echo "Seleccione editor:"
    select editor in "nano" "vi"; do
        [ "$editor" ] && break
    done
    EDITOR=$editor
}

# Editar archivo existente
list_and_edit_file() {
    local path=$1
    echo "Archivos en: $path"
    select file in $(ls "$path"); do
        [ "$file" ] && $EDITOR "$path/$file" && break
    done
}

# Crear nuevo share SMB
add_smb_share() {
    echo -n "Nombre del share SMB: "
    read share_name
    echo -n "Ruta del directorio a compartir: "
    read share_path

    cat <<EOF > "$CONFIG_DIR/$share_name.conf"
[$share_name]
   path = $share_path
   browseable = yes
   read only = no
   guest ok = no
   create mask = 0775
   directory mask = 0775
EOF

    echo "[+] Share SMB '$share_name' creado."
    rc-service samba restart
}

# Editar configuración SMB
edit_smb_share() {
    list_and_edit_file "$CONFIG_DIR"
    rc-service samba restart
}

# Crear nuevo export NFS
add_nfs_export() {
    echo -n "Ruta a exportar vía NFS: "
    read export_path
    echo -n "Red/IP permitida (ej. 192.168.1.0/24): "
    read export_network

    echo "$export_path $export_network(rw,sync,no_subtree_check)" >> "$NFS_EXPORTS"
    exportfs -ra
    rc-service nfs restart
    echo "[+] Export NFS agregado."
}

# Editar exports NFS
edit_nfs_exports() {
    $EDITOR "$NFS_EXPORTS"
    exportfs -ra
    rc-service nfs restart
}

# Menú principal
main_menu() {
    while true; do
        clear
        echo "=== NAS Share TUI Admin ==="
        echo "1) Agregar share SMB"
        echo "2) Editar share SMB"
        echo "3) Agregar export NFS"
        echo "4) Editar exports NFS"
        echo "5) Salir"
        echo -n "Opción [1-5]: "
        read opt
        case $opt in
            1) add_smb_share ;;
            2) edit_smb_share ;;
            3) add_nfs_export ;;
            4) edit_nfs_exports ;;
            5) exit 0 ;;
            *) echo "Opción inválida" && sleep 1 ;;
        esac
    done
}

# Ejecutar
init_config
choose_editor
main_menu
