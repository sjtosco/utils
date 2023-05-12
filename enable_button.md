First remove xserver-xorg-input-synaptics and install xserver-xorg-input-libinput

After, add the following lines to /usr/share/X11/xorg.conf.d/40-libinput.conf
```
Section  "InputClass"
    Identifier  "touchpad overrides"
    Driver "libinput"
    MatchIsTouchpad "on"
    Option "Tapping" "on"
    Option "TappingButtonMap" "lrm"
EndSection
```
And reboot now.-
