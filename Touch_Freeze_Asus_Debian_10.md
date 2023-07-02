## Update Debian 12

Create **/lib/systemd/system-sleep/touchpad**

```bash
#!/bin/sh

case $1 in
	post)
		/sbin/rmmod i2c-hid-acpi && /sbin/modprobe i2c-hid-acpi
	;;
esac
```
Do: sudo chmod +x /lib/systemd/system-sleep/touchpad


> Based on:https://forums.linuxmint.com/viewtopic.php?t=127984


## DEBIAN 10
Create **/lib/systemd/system-sleep/touchpad**

```bash
#!/bin/sh

case $1 in
	post)
		/sbin/rmmod i2c_hid && /sbin/modprobe i2c_hid
	;;
esac
```
Do: sudo chmod +x /lib/systemd/system-sleep/touchpad


> Based on: https://unix.stackexchange.com/questions/309247/linux-mouse-freezes-after-suspend
