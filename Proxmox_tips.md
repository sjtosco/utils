# Add new disk and partitioning

pvcreate /dev/sdb
luego lo agregas a un grupo de volúmenes nuevo
vgcreate produccion /dev/sdb
ahora viene la parte que necesitas partir (respaldos y data)
lvcreate -L 150G produccion -n backups
lvcreate -l 100%FREE –thinpool storage produccion

Finalmente formateamos y montamos (esto lo puedes hacer desde el admin del proxmox)
mkfs /dev/mapper/produccion-backups
mkfs /dev/mapper/produccion-storage

Add line in `/etc/fstab`:
`/dev/hdd/backups /mnt/backups ext4 defaults 0 2`

reboot

In proxmox GUI add Directory and LVM.
Enjoy!
