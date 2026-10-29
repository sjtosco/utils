# VGA USB adaptador

MacroSilicon MS9132/MS9133 (345f:9132) USB display Linux DRM driver.
> Info: [https://github.com/bambinounos/ms91xx-linux-drm](https://github.com/bambinounos/ms91xx-linux-drm)

Prerequisitos:

```
sudo apt install rsync build-essential linux-headers-amd64 dkms
```

Ahora descargar repo:

```
git clone https://github.com/bambinounos/ms91xx-linux-drm.git
cd ms91xx-lunux-drm
```

**Solo** para *versión 3.1.4 o inferior*, editar ´drm/msdisp_drm_fb.c´:
* In 394 Change kernel version. #if KERNEL_VERSION(6, 1, 0) <= LINUX_VERSION_CODE (before was "6,18,0")
* In 431 Change kernel version. #if KERNEL_VERSION(6, 1, 0) > LINUX_VERSION_CODE (before was "6,18,0")

Si hubo intentos fallidos, limpiar

```
sudo ./dkms-remove.sh
sudo dkms remove msdisp/3.1.4 --all
sudo rm -rf /usr/src/msdisp-3.1.4
sudo rm -rf /usr/src/linux-headers-6.12.111+deb13-amd64/
```

Ahora instalar (o reinstalar):

```
sudo ./dkms-install.sh
```
