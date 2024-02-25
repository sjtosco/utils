# Fix error iwlwifi_yoyo.bin 

Check error: `sudo dmesg | grep yoyo`

```
iwlwifi 0000:02:00.0: firmware: failed to load iwl-debug-yoyo.bin (-2)
```

Fix... Create file `sudo vi /etc/modprobe.d/iwlwifi.conf` with:

```
options iwlwifi enable_ini=0
```

Finally: `sudo update-initramfs -u`
