# Zswap debian 12 enable

## Standard way

Just append to `GRUB_CMDLINE_LINUX_DEFAULT` in `/etc/default/grub`:

```
zswap.enabled=1
```

Modify swappiness, create `/etc/sysctl.d/custom.conf`:

```
vm.swappiness=25
```

## Tweaks

> [Reddit info](https://www.reddit.com/r/debian/comments/q2ux4c/how_to_install_zswap/)

Add to `/etc/initramfs-tools/modules`:

```
lz4
lz4_compress
z3fold
```

Update or append in `GRUB_CMDLINE_LINUX_DEFAULT` in `/etc/default/grub`:

`zswap.max_pool_percent=25 zswap.zpool=z3fold zswap.compressor=lz4`

