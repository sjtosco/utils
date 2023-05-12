> Based on: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=731429


```
$ xhost +SI:localuser:Debian-gdm

$ su
<type-your-password>

# DISPLAY=:0 sudo -u Debian-gdm gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
```
