## Touchpad ELAN 

### Proposed in video (not tested solution)
[https://www.youtube.com/watch?v=zndRh0ngXKs](https://www.youtube.com/watch?v=zndRh0ngXKs)
### New solution (Debian 11)

en /etc/default/grub modify/add:
```
GRUB_DEFAULT=0
GRUB_TIMEOUT=0
GRUB_TIMEOUT_STYLE=hidden
GRUB_HIDDEN_TIMEOUT_QUIET=true
GRUB_DISTRIBUTOR=`lsb_release -i -s 2> /dev/null || echo Debian`
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash pci=nocrs" 
GRUB_CMDLINE_LINUX="initcall_blacklist=elants_i2c_driver_init"
```
> Maybe *initcall_blacklist=elants_i2c_driver_init* Not needed.

sudo update-grub 

reboot

### Old Solution

With this steps the problems if fixed (For now)

> WEB: https://askubuntu.com/questions/1220264/lenovo-ideapad-s145-touchpad-not-working/1266740#1266740

I had this same issue. The problem is with the kernel. The kernel hasn't detected the touch pad. Firstly edit the kernel boot parameters. This is what i did to solve it - EDIT: It is recommended to take a backup using cp /etc/default/grub /etc/default/grub.bak

    sudo nano /etc/default/grub
    Edit GRUB_CMDLINE_LINUX_DEFAULT to GRUB_CMDLINE_LINUX_DEFAULT="quiet i8042.nopnp=1 pci=nocrs" 
    Now save and exit.
    Run sudo update-grub

The next steps will be to patch the kernel

    Now run git clone https://github.com/pavlepiramida/elan_i2c_dkms.git
    After that install make and dkms, so run sudo apt install make dkms
    Now run cd elan_i2c_dkms
    After that run sudo dkms install .
    Finally, run reboot


Now, once you reboot, the touch pad should be working...

For install new kernel (5+ from backports) that enable Debian 10 support for new S340 Lenovo Laptop:
> WEB: https://unix.stackexchange.com/questions/545601/how-to-upgrade-the-debian-10-kernel-from-backports-without-recompiling-it-from-s

```
echo deb http://deb.debian.org/debian buster-backports main contrib non-free | sudo tee /etc/apt/sources.list.d/buster-backports.list
sudo apt update
sudo apt install -t buster-backports linux-image-amd64
sudo apt install -t buster-backports firmware-linux firmware-linux-nonfree firmware-realtek 
sudo reboot
```
After boot in new kernel...
```
sudo apt install linux-headers-$(uname -r)
```


Easy fix (kernel 5.4):
Add to grub
GRUB_CMDLINE_LINUX_DEFAULT="quiet pci=nocrs" 

Bios in Only UEFI and Secure Bott Disabled

## snd_hda_intel no response from codec

> Web: https://forums.linuxmint.com/viewtopic.php?t=306711&start=20

add to file */etc/modprobe.d/alsa-base.conf* this line: **options snd-hda-intel model=dual-codecs**

## Airplane Mode

### New for Gnome Desktop
Creates a file */usr/local/bin/airplanemode-toggle.sh* with this:

```
#!/usr/bin/env bash
wifi="$(nmcli r wifi | awk 'FNR = 2 {print $1}')"
if [ "$wifi" == "enabled" ] 
then
    nmcli r wifi off
else
    nmcli r wifi on
fi

```
Adjust keyboard shortkey to ,MOD4.+F7

### Old for Gnome Desktop
Creates a file */usr/local/bin/airplanemode-toggle.sh* with this:

```
#!/usr/bin/env bash
/usr/sbin/rfkill list | grep -q '\byes\b' && /usr/sbin/rfkill unblock all || /usr/sbin/rfkill block all
```

Alternatively create shortcut with:

```
pkexec sh -c "/usr/sbin/rfkill list | grep -q '\byes\b' && /usr/sbin/rfkill unblock all || /usr/sbin/rfkill block all"
```

Adjust keyboard shortkey to ,MOD4.+F7

### Other desktop

Install `libnotify-bin` package.

Creates a file */usr/local/bin/airplanemode-toggle.sh* with this:
```bash
#!/usr/bin/env bash

wifi=$(nmcli r wifi | awk 'FNR = 2 {print $1}');
if [ "$wifi" == "enabled" ]; then 
        #/usr/sbin/rfkill block bluetooth;
        #/usr/sbin/rfkill block wlan;
        /usr/bin/notify-send -t 2000 -i network-wireless-offline "Airplane mode ON";
else 
        #/usr/sbin/rfkill unblock bluetooth;
        #/usr/sbin/rfkill unblock wlan;
        /usr/bin/notify-send -t 2000 -i network-wireless-offline "Airplane mode OFF";
fi
```
Adjust keyboard shortkey to ,MOD4.+F7

## Camera ON/OFF

Creates a file */usr/local/bin/camera-toggle.sh* with this:
```bash
#!/usr/bin/env bash

wifi="$(lsmod | grep uvcvideo)"
if [ -z "$wifi" ]; then
	pkexec /sbin/modprobe uvcvideo;
	/usr/bin/notify-send -t 2000 -i camera-web "Camera ON";
else
	pkexec /sbin/rmmod uvcvideo;
	/usr/bin/notify-send -t 2000 -i camera-web "Camera OFF"
fi
```

NEW VERSION:

```
#!/usr/bin/env bash

device="1-5"
# Verificar si el módulo uvcvideo está cargado
if ls /sys/bus/usb/drivers/usb/ | grep -q $device; then
    # Si está cargado, desactivar la cámara
    echo $device | sudo tee /sys/bus/usb/drivers/usb/unbind
    /usr/bin/notify-send -t 2000 -i camera-web "Camera OFF"
else
    # Si no está cargado, activar la cámara
    echo $device | sudo tee /sys/bus/usb/drivers/usb/bind
    /usr/bin/notify-send -t 2000 -i camera-web "Camera ON"
fi

```

Adjust keyboard shortkey to ,MOD4.+F8

## Mic Toggle

### Simplest (Debian 11)
In *Keyboard shortcuts>Microphone mute/unmute* asociate <SUPER>+<F4>

### Custom script
Creates a file */usr/local/bin/mic-toggle* with this:
```bash
#!/usr/bin/env bash
amixer set Capture toggle && amixer get Capture | grep '\[off\]' && notify-send -t 1000 -i stock_mic "MIC switched OFF" || notify-send -t 1000 -i stock_mic "MIC switched ON"
```
adjust for mod4+f4

## Brightness NEW SOLUTION

### Wayland support hardware

Creates shortcut with these commands:

```
# UP
brightnessctl -d "intel_backlight" set 5%+

#DOWN
brightnessctl -d "intel_backlight" set 5%-
```

### XDOTOOL (XORG only)

Install `sudo apt install xdotool` . Configure shortcuts for:
* xdotool sleep 0.5 key XF86MonBrightnessUP  (Maybe use 233 code)
* xdotool sleep 0.5 key XF86MonBrightnessDOWN (Maybe use 232 code)

## Brightness up
Creates a file */usr/local/bin/brightness_up* with this:
```bash
#!/usr/bin/env bash
BRIGHTNESS_FILE=/sys/class/backlight/intel_backlight/brightness
MAX_BRIGHTNESS=$(cat /sys/class/backlight/intel_backlight/max_brightness)
ACTUAL_BRIGHTNESS=$(cat /sys/class/backlight/intel_backlight/actual_brightness)
STEP=$((MAX_BRIGHTNESS / 20 + 1))
new=$((ACTUAL_BRIGHTNESS + STEP))
#if [ "$new" -lt "0" ]; then
#	$new=0
#fi
if ((new > MAX_BRIGHTNESS )); then
	new=$MAX_BRIGHTNESS
	/usr/bin/notify-send -t 1000 -i gtk-dialog-warning "Brightness 100%"
else
	/usr/bin/notify-send -t 1000 -i video-display "Brightness $((ACTUAL_BRIGHTNESS * 100 / MAX_BRIGHTNESS))%"
fi
echo $new > $BRIGHTNESS_FILE
```
adjust for mod4+f12

## Brightness down

Creates a file */usr/local/bin/brightness_down* with this:
```bash
#!/usr/bin/env bash
BRIGHTNESS_FILE=/sys/class/backlight/intel_backlight/brightness
MAX_BRIGHTNESS=$(cat /sys/class/backlight/intel_backlight/max_brightness)
ACTUAL_BRIGHTNESS=$(cat /sys/class/backlight/intel_backlight/actual_brightness)
STEP=$((MAX_BRIGHTNESS / 20))
new=$((ACTUAL_BRIGHTNESS - STEP))


if (( new < 0 )); then
	new=0
else
	/usr/bin/notify-send -t 1000 -i video-display "Brightness $((ACTUAL_BRIGHTNESS * 100 / MAX_BRIGHTNESS))%"
fi

#if [ "$new" -gt "$MAX_BRIGHTNESS" ]; then
#	$new=$MAX_BRIGHTNESS
#fi
echo $new > $BRIGHTNESS_FILE
```
adjust for mod4+f11


## SND_INTEL ERROR NO CODEC
`sudo tee /etc/modprobe.d/snd-hda-intel-fix.conf <<<'options snd-hda-intel probe_mask=1'`
and reboot

> From: https://forums.linuxmint.com/viewtopic.php?t=327629

## English composite key ALTGR

1. Open the Activities overview and start typing Tweaks.
2. Click Tweaks to open the application.
3. Click the Keyboard & Mouse tab.
4. Click Disabled next to the Compose Key setting.
5. Turn the switch on in the dialog and pick the keyboard shortcut you want to use.
6. Tick the checkbox of the key that you want to set as the Compose key.
7. Close the dialog.
8. Close the Tweaks window.

> https://help.gnome.org/users/gnome-help/stable/tips-specialchars.html.en 
