# Optimize GNOME

## /etc/sysctl.conf

Add this configuration on the file.
```bash
vm.swappiness = 10
vm.vfs_cache_pressure = 50
vm.watermark_scale_factor = 200
vm.dirty_ratio = 3
```

## /etc/sysctl.d/.local.conf

#vm.swappiness = 60
#vm.vfs_cache_pressure = 100
#vm.dirty_writeback_centisecs = 500

vm.swappiness = 10
vm.vfs_cache_pressure = 100
vm.dirty_writeback_centisecs = 1500

## Bibliography

* https://geekland.eu/mejorar-el-rendimiento-de-un-sistema-operativo-de-escritorio-linux/
