#!/bin/bash

CONFIG_DIR="/etc/samba/smb.conf.d"
SMB_CONF_MAIN="/etc/samba/smb.conf"
NFS_EXPORTS="/etc/exports"

show_help() {
    echo "Uso: nas-share-tui [opción]"
    echo
    echo "Opciones:"
    echo "  -h, --help      Mostrar esta ayuda"
    exit 0
}

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    show_help
fi

init_config() {
    mkdir -p "$CONFIG_DIR"
    grep -q "$CONFIG_DIR" "$SMB_CONF_MAIN" || echo "include = $CONFIG_DIR/*.conf" >> "$SMB_CONF_MAIN"
}

choose_editor() {
    echo "Seleccione editor:"
    select editor in "nano" "vi"; do
        [[ "$editor" ]] && break
    done
    EDITOR="$editor"
}

list_and_edit_file() {
    local path=$1
    echo "Archivos en: $path"
    select file in $(ls "$path"); do
        [[ "$file" ]] && $EDITOR "$path/$file" && break
    done
}

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

edit_smb_share() {
    list_and_edit_file "$CONFIG_DIR"
    rc-service samba restart
}

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

edit_nfs_exports() {
    $EDITOR "$NFS_EXPORTS"
    exportfs -ra
    rc-service nfs restart
}

show_status_services() {
    echo "===== Estado de Servicios ====="
    echo
    echo "[Samba]"
    rc-service samba status
    echo
    echo "[NFS]"
    rc-service nfs status
    rc-service rpc.statd status
    echo "==============================="
    echo
    read -p "Presione Enter para volver..."
}

submenu_service_samba() {
    while true; do
        clear
        echo "=== Gestión de Samba ==="
        echo "1) Iniciar"
        echo "2) Detener"
        echo "3) Estado"
        echo "4) Habilitar al inicio"
        echo "5) Deshabilitar del inicio"
        echo "0) Volver"
        read -p "Opción: " opt
        case "$opt" in
            1) rc-service samba start ;;
            2) rc-service samba stop ;;
            3) rc-service samba status ;;
            4) rc-update add samba ;;
            5) rc-update del samba ;;
            0) break ;;
            *) echo "Opción inválida" && sleep 1 ;;
        esac
    done
}

submenu_service_nfs() {
    while true; do
        clear
        echo "=== Gestión de NFS ==="
        echo "1) Iniciar"
        echo "2) Detener"
        echo "3) Estado"
        echo "4) Habilitar al inicio"
        echo "5) Deshabilitar del inicio"
        echo "0) Volver"
        read -p "Opción: " opt
        case "$opt" in
            1) rc-service nfs start && rc-service rpc.statd start ;;
            2) rc-service nfs stop && rc-service rpc.statd stop ;;
            3) rc-service nfs status && rc-service rpc.statd status ;;
            4) rc-update add nfs && rc-update add rpc.statd ;;
            5) rc-update del nfs && rc-update del rpc.statd ;;
            0) break ;;
            *) echo "Opción inválida" && sleep 1 ;;
        esac
    done
}

manage_services() {
    while true; do
        clear
        echo "=== Gestión de Servicios ==="
        echo "1) Estado de Samba y NFS"
        echo "2) Gestionar Samba"
        echo "3) Gestionar NFS"
        echo "0) Volver"
        read -p "Opción: " opt
        case "$opt" in
            1) show_status_services ;;
            2) submenu_service_samba ;;
            3) submenu_service_nfs ;;
            0) break ;;
            *) echo "Opción inválida" && sleep 1 ;;
        esac
    done
}

main_menu() {
    while true; do
        clear
        echo "=== NAS Share TUI ==="
        echo "1) Agregar share SMB"
        echo "2) Editar share SMB"
        echo "3) Agregar export NFS"
        echo "4) Editar exports NFS"
        echo "5) Servicios SMB/NFS"
        echo "6) Salir"
        read -p "Opción [1-6]: " opt
        case "$opt" in
            1) add_smb_share ;;
            2) edit_smb_share ;;
            3) add_nfs_export ;;
            4) edit_nfs_exports ;;
            5) manage_services ;;
            6) exit 0 ;;
            *) echo "Opción inválida" && sleep 1 ;;
        esac
    done
}

# Ejecutar
init_config
choose_editor
main_menu
