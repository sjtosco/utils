# OS flavor

Animated Pymouth: `sudo apt install plymouth-themes`

Prerequisites: `sudo apt install `

Download from [https://www.gnome-look.org/p/1888173/](https://www.gnome-look.org/p/1888173/).

Uncompress and `mv debian-logo /usr/share/plymouth/themes/`.

```
sudo plymouth-set-default-theme -l
sudo plymouth-set-default-theme -R debian-logo
```

Fix Debian 11 Logo in boot adding this two lines in `/usr/share/plymouth/themes/debian-logo/debian-logo.plymouth`, `[two-steps]`
section:

```
WatermarkHorizontalAlignment=1.5
WatermarkVerticalAlignment=1.5
```

Change `/etc/default/grub`:

```
GRUB_DEFAULT="0"
GRUB_TIMEOUT="0"
#GRUB_TIMEOUT_STYLE="hidden"
#GRUB_HIDDEN_TIMEOUT="0"
#GRUB_HIDDEN_TIMEOUT_QUIET="true"
GRUB_DISABLE_OS_PROBER="true"
GRUB_DISTRIBUTOR="`lsb_release -i -s 2> /dev/null || echo Debian`"
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash noresume"
GRUB_CMDLINE_LINUX=""
```

Grub Customizer: change background image with 1920 * 1080 black frame.

