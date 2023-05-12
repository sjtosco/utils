Create an script in /usr/local/share called toggle_touchpad.sh and give it execution permission

```bash
#!/bin/bash

device=11
state=`xinput list-props "$device" | grep "Device Enabled" | grep -o "[01]$"`

if [ $state == '1' ];then
  xinput --disable $device
  notify-send -i emblem-nowrite "Touchpad" "Disabled"
else
  xinput --enable $device
  notify-send -i input-touchpad "Touchpad" "Enabled"
fi
```

After configure shortcut in xfce4.
