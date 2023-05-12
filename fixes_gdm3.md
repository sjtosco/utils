# GDM3 Fixes in Gnome Debian 11
## Mouse theme
From: [https://askubuntu.com/questions/1152547/how-to-change-the-ubuntu-19-04-gdm3-cursor-theme](https://askubuntu.com/questions/1152547/how-to-change-the-ubuntu-19-04-gdm3-cursor-theme):
Add at end of file `/etc/gdm3/greeter.dconf-defaults`:
```
# Theming options
# ===============
[org/gnome/desktop/interface]
cursor-theme='CURSOR_NAME'
#cursor-size=35
#[org/gnome/desktop/peripherals/mouse]
#speed=-0.8
```
## Display layout

From: [https://askubuntu.com/questions/11738/force-gdm-login-screen-to-the-primary-monitor](https://askubuntu.com/questions/11738/force-gdm-login-screen-to-the-primary-monitor):
`sudo cp ~/.config/monitors.xml  /var/lib/gdm3/.config/`
