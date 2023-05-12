# Predictable network interfaces names in Debian 10 (buster)

I have problems with usb modems. With this line the modems are recognized ok.

sudo ln -s /lib/udev/rules.d/80-net-setup-link.rules /etc/udev/rules.d/80-net-setup-link.rules

> Based on: https://www.raspberrypi.org/forums/viewtopic.php?t=191639
> Info about predictable names: https://www.freedesktop.org/wiki/Software/systemd/PredictableNetworkInterfaceNames/
