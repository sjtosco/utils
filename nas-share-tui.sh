#!/bin/bash

CONFIG_DIR="/etc/samba/smb.conf.d"
SMB_CONF_MAIN="/etc/samba/smb.conf"
NFS_EXPORTS="/etc/exports"

show_help() {
    echo "Uso: $(basename "$0") [opción]"
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
    grep -q "include = $CONFIG_DIR/*.conf" "$SMB_CONF_MAIN" 2>/dev/null || echo "include = $CONFIG_DIR/*.conf" >> "$SMB_CONF_MAIN"
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
    local files=($(ls "$path" 2>/dev/null))
    if [ ${#files[@]} -eq 0 ]; then
        echo "No hay archivos para editar en $path."
        sleep 1
        return
    fi
    echo "Archivos en: $path"
    select file in "${files[@]}" "Cancelar"; do
        if [[ "$file" == "Cancelar" ]]; then
            break
        elif [ "$file" ]; then
            $EDITOR "$path/$file"
            break
        else
            echo "Opción inválida."
        fi
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
    sleep 1
}

# Editar configuración SMB
edit_smb_share() {
    list_and_edit_file "$CONFIG_DIR"
    rc-service samba restart
    sleep 1
}

# Borrar share SMB
delete_smb_share() {
    local files=($(ls "$CONFIG_DIR" 2>/dev/null))
    if [ ${#files[@]} -eq 0 ]; then
        echo "No hay shares SMB para borrar."
        sleep 1
        return
    fi

    echo "Selecciona el share SMB a borrar:"
    select file in "${files[@]}" "Cancelar"; do
        if [[ "$file" == "Cancelar" ]]; then
            break
        elif [ "$file" ]; then
            echo -n "¿Seguro que deseas borrar el share '$file'? [s/N]: "
            read confirm
            if [[ "$confirm" =~ ^[sS]$ ]]; then
                rm -f "$CONFIG_DIR/$file"
                rc-service samba restart
                echo "Share SMB '$file' borrado y samba reiniciado."
                sleep 1
            else
                echo "Cancelado."
                sleep 1
            fi
            break
        else
            echo "Opción inválida."
        fi
    done
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
    sleep 1
}

# Editar exports NFS
edit_nfs_exports() {
    $EDITOR "$NFS_EXPORTS"
    exportfs -ra
    rc-service nfs restart
    sleep 1
}

# Mostrar estado servicios SMB y NFS
service_status() {
    echo "Estado de servicios:"
    for svc in samba nfs; do
        status=$(rc-service "$svc" status 2>&1)
        if echo "$status" | grep -q "started"; then
            run_status="en ejecución"
        else
            run_status="detenido"
        fi

        if rc-update show | grep -q "^$svc.*default"; then
            enabled_status="habilitado"
        else
            enabled_status="deshabilitado"
        fi

        echo "- $svc: $run_status, inicio $enabled_status"
    done
    echo
    read -rp "Presiona Enter para continuar..."
}

# Control de servicios SMB y NFS
service_control() {
    echo "Control servicios:"
    select opt in "Iniciar" "Detener" "Reiniciar" "Habilitar inicio" "Deshabilitar inicio" "Volver"; do
        case $opt in
            "Iniciar")
                rc-service samba start
                rc-service nfs start
                echo "Servicios iniciados."
                ;;
            "Detener")
                rc-service samba stop
                rc-service nfs stop
                echo "Servicios detenidos."
                ;;
            "Reiniciar")
                rc-service samba restart
                rc-service nfs restart
                echo "Servicios reiniciados."
                ;;
            "Habilitar inicio")
                rc-update add samba default
                rc-update add nfs default
                echo "Servicios habilitados en inicio."
                ;;
            "Deshabilitar inicio")
                rc-update del samba default
                rc-update del nfs default
                echo "Servicios deshabilitados en inicio."
                ;;
            "Volver")
                break
                ;;
            *)
                echo "Opción inválida."
                ;;
        esac
        sleep 1
    done
}

service_menu() {
    while true; do
        clear
        echo "=== Administración de Servicios ==="
        echo "1) Estado servicios SMB y NFS"
        echo "2) Control servicios SMB y NFS"
        echo "3) Volver"
        echo -n "Opción [1-3]: "
        read opt
        case $opt in
            1) service_status ;;
            2) service_control ;;
            3) break ;;
            *) echo "Opción inválida" && sleep 1 ;;
        esac
    done
}

# Menú principal
main_menu() {
    while true; do
        clear
        echo "=== NAS Share TUI Admin ==="
        echo "1) Agregar share SMB"
        echo "2) Editar share SMB"
        echo "3) Borrar share SMB"
        echo "4) Agregar export NFS"
        echo "5) Editar exports NFS"
        echo "6) Administración servicios"
        echo "7) Salir"
        echo -n "Opción [1-7]: "
        read opt
        case $opt in
            1) add_smb_share ;;
            2) edit_smb_share ;;
            3) delete_smb_share ;;
            4) add_nfs_export ;;
            5) edit_nfs_exports ;;
            6) service_menu ;;
            7) exit 0 ;;
            *) echo "Opción inválida" && sleep 1 ;;
        esac
    done
}

# Ejecutar
init_config
choose_editor
main_menu
