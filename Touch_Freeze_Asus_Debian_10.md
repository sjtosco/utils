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
