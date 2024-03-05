# Debian 12 Minimal Gnome Shell

## Prerequisites

Install from net install image, using expert mode; in tasksel window, select only last option.

> NOTE: You can install from backports a new kernel if it's needed.

When reboot, you have a text-mode login. For minimal GUI install:

```
sudo apt install gnome-shell gnome-terminal
```

Reboot for enter in GUI mode.

## Basic apps

After login install Nautilus, Text Editor, basic Shell-Extensions and other basic utilities from Terminal:

```
sudo apt install gnome-text-editor nautilus nautilus-dropbox nautilus-admin nautilus-image-converter gnome-tweaks gnome-shell-extension-manager gnome-shell-extension-caffeine gnome-shell-extension-top-icons-plus gnome-disk-utility gnome-system-monitor gnome-power-manager htop ifstat iotop vim
```

Firmware and basic build tools:

```
sudo apt install firmware-linux firmware-realtek firmware-atheros firmware-b43-installer firmware-ti-connectivity firmware-iwlwifi git linux-headers-$(uname -r) intel-media-va-driver-non-free build-essential cmake mesa-utils
```

Reboot

### Firefox latest (stable)

> From [https://www.mozilla.org/es-AR/firefox/linux/](https://www.mozilla.org/es-AR/firefox/linux/)

To install the .deb package through the APT repository, do the following:

```
sudo install -d -m 0755 /etc/apt/keyrings

wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null

echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | sudo tee -a /etc/apt/sources.list.d/mozilla.list > /dev/null

# See NOTE below...

echo '
    Package: *
    Pin: origin packages.mozilla.org
    Pin-Priority: 1000
    ' | sudo tee /etc/apt/preferences.d/mozilla

sudo apt-get update && sudo apt-get install firefox
```

> NOTE: You can verify before install

```
gpg -n -q --import --import-options import-show /etc/apt/keyrings/packages.mozilla.org.asc | awk '/pub/{getline; gsub(/^ +| +$/,""); if($0 == "35BAA0B33E9EB396F59CA838C0BA5CE6DC6315A3") print "\nThe key fingerprint matches ("$0").\n"; else print "\nVerification failed: the fingerprint ("$0") does not match the expected one.\n"}'
```

> Important: First at all when start Firefox, install *ublock origin* add-on.

### Mail Client

```
sudo apt install thunderbird
```

Now you can configure your email accounts.

### Software store

> From [https://flatpak.org/setup/Debian](https://flatpak.org/setup/Debian)
Gnome store and flatpak:

```
sudo apt install -y flatpak
sudo apt install -y gnome-software gnome-software-plugin-flatpak
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
```

## First adjusts and fixes

### Network

From `/etc/network/interfaces` remove network config for any interface but *lo* (loopback).

### Grub

Silent grub and zswap:

```
GRUB_DEFAULT=0
GRUB_TIMEOUT=2
GRUB_TIMEOUT_STYLE=hidden
GRUB_HIDDEN_TIMEOUT_QUIET=true
GRUB_DISTRIBUTOR=`lsb_release -i -s 2> /dev/null || echo Debian`
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash zswap.enabled=1" 
GRUB_CMDLINE_LINUX=""
```

Apply with: `sudo update-grub`.

Reboot.

### Shortcuts

Add custom shortcuts.

### Adjust display

From *Settings> Display* adjust display config and enable Night Light.

### Power button behavior

Set *Settings > Power > Power button behavior* to **Power Off**

### Touchpad (if applies)

Adjust from *Settings > Mouse & Touchpad*.

### Microphone and volume

Adjust volume and other setting from *Settings > Sound*

### Search

Adjust *Settings > Search*.

### Other fixes

At this time, fix other possibles problems and errors.

## Supplemental Desktop Environment (DE) Apps

> Partially from [https://linuxete.duckdns.org/que-hacer-despues-de-instalar-debian-12/](https://linuxete.duckdns.org/que-hacer-despues-de-instalar-debian-12/)

```
sudo apt install -y eog shotwell evince fonts-cantarell fonts-noto-color-emoji gnome-characters apt-xapian-index synaptic gdebi nvme-cli

sudo apt install -y rar unrar unace p7zip-full p7zip-rar lzip arj sharutils mpack lzma lzop unzip zip bzip2 lhasa cabextract lrzip rzip zpaq kgb xz-utils file-roller menulibre

sudo apt install -y ttf-mscorefonts-installer && sudo fc-cache -fv
sudo apt install -y font-manager gnome-font-viewer 

sudo apt install -y mtp-tools ipheth-utils ideviceinstaller ifuse
sudo apt install -y exfat-fuse hfsplus hfsutils ntfs-3g

sudo apt install -y default-jre gufw guvcview winff qv4l2 glabels

sudo apt install -y gnome-weather dconf-editor

sudo apt install -y dia dia-shapes dia-rib-network
```

## Themes

```
sudo apt install -t bookworm-backports papirus-icon-theme -y
```

## Others from flatpak

* Avidemux
* Kolourpaint
* Gear Lever
* Onlyoffice
* Audacity
* Kdenlive
* OBS (with plugins)
* Speedtest
* Gimp (with plugins)
* Inkscape
* Scribus
* Bottles (`flatpak override com.usebottles.bottles --user --filesystem=xdg-data/applications`)
* Libreoffice
* Draw.io

## Others with Wine

* Winbox

## Others from appimage

* Stellarium
* Balena Etcher
* Netron
* Lumi
* MQTT Explorer
* Shadowsocks-qt5
* HTTPie
* RustDesk

## Others from third party debs

* Google Chrome
* Pencil Project
* Webapp-manager
* VSCode
* Anydesk
* Teamviewer

> NOTE: `sudo systemctl disable --now anydesk.service teamviewerd.service`

## Network apps and plugins

```
sudo apt install wireshark network-manager-openvpn-gnome network-manager-l2tp-gnome network-manager-pptp-gnome libreswan ethtool
sudo groupadd wireshark
sudo usermod -a -G wireshark $USER
```

## Development utils and apps

### Custom
Create `/usr/local/bin/get-extip` **(chmod +x)**

```
#!/usr/bin/env bash
/usr/bin/dig +short myip.opendns.com @resolver1.opendns.com
```

Create `/usr/local/bin/remove_pycache` **(chmod +x)**

```
#!/usr/bin/env bash
if [ -z "$1" ]; then
    find . | grep -E "(/__pycache__$|\.pyc$|\.pyo$)" | xargs rm -rf;
else
    find "$1" | grep -E "(/__pycache__$|\.pyc$|\.pyo$)" | xargs rm -rf;
fi
```

### Virtualbox

Install from [official site](https://www.virtualbox.org/wiki/Downloads)

### Pipx

```
sudo apt install pipx --no-install-recommends
pipx ensurepath
```

Add to `$HOME/.bashrc` below other *pipx* related lines:

```
eval "$(register-python-argcomplete pipx)"
```

### Virtualenvwrapper

```
pipx install virtualenvwrapper
```

In `$HOME/.bashrc` file add:
```
# virtualenv and virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=$HOME/.local/pipx/venvs/virtualenvwrapper/bin/python3
source $HOME/.local/pipx/venvs/virtualenvwrapper/bin/virtualenvwrapper.sh
```
