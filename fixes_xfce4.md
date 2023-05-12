# Xfce4 fixes and simple theming

Startig from Debian 11 netinstall iso; choose XFCE desktop.
Configure and install usefull repos, utilites and applications: 
* Backports
* Fasttrack
* VBox (ext and guest-iso included)
* Utilities: git, htop, ifstat, vim, aria2, python3-pip, intel_gpu_tools, font-manager, wireshark, menulibre, gdebi, flatpak, tomboy-ng
* Configure shortcuts following GNOME layout and notifications to 5 secs.
* Firmware: `sudo apt install firmware-linux firmware-iwlwifi firmware-realtek firmware-atheros firmware-ivtv firmware-ti-connectivity firmware-netxen`
* Compressors: `sudo apt install rar unrar unace p7zip-full p7zip-rar lzip arj sharutils mpack lzma lzop unzip zip bzip2 lhasa cabextract lrzip rzip zpaq kgb xz-utils`
* Win fonts: `sudo apt install ttf-mscorefonts-installer` (Update cache: `sudo fc-cache -fv`)
* Install docker-ce engine
* Design apps: `sudo apt install gimp gimp-cbmplugs gimp-data-extras gimp-dds gimp-gap gimp-gmic gimp-help-es gimp-lensfun gimp-texturize inkscape inkscape-open-symbols inkscape-textext inkscape-tutorials scribus scribus-template dia dia-shapes dia-rib-network && flatpak install kolourpaint && flatpak install flatseal`
* Special comm apps: `sudo apt install remmina remmina-plugin-spice remmina-plugin-nx remmina-plugin-xdmcp filezilla`
* Download and install: vscode, webapps (mint deb), mintstick (mint deb), Anydesk (disable service)

## Fix user access permissions

```
sudo usermod -aG vboxusers $USER
sudo usermod -aG wireshark $USER
sudo usermod -aG docker $USER
```

## Fix gdebi

Use *Menulibre* and edit *gdebi* shortcut with: `sh -c "gdebi-gtk %f"`

## Fix Synaptic

```
sudo apt install apt-xapian-index
sudo dpkg-reconfigure synaptic
```
Logout

## Fix Theme application problem

> Web: [Forum XFCE](https://forum.xfce.org/viewtopic.php?id=15305)

Client Side Decorations (CSD) and they are not drawn by the window manager but rather the application itself.

```
sudo apt install gtk3-nocsd
```
## Fix Super Key for Whisker launcher

Install `sudo apt install xcape` and configure from terminal an in Startup Applications menu: 

```
xcape -e "Super_L=Alt_L|Escape"
```
You should be able to prevent the "sticky keys" notification from appearing by unchecking (blocking) the "xfce4-settings-helper" application in Settings Manager > Notifications > Applications tab. Moreover, ensure that Sticky keys are disable in Accesibility > Keyboard Tab.

## "Batteries to" Thunar

`sudo apt install thunar-gtkhash thunar-vcs-plugin thunar-font-manager`

## zram

Install and configure to 512MB max (on `/etc/defaults/zramswap`)

`sudo apt install zram-tools`

## Theming

Icons: `sudo apt install -t bullseye-backports papirus-icon-theme`

# Tearing

How to Fix Intel Screen Tearing on Xfce

    Go to “setting manager”
    Go to “setting editor”
    Choose “xfwm4”
    Find “vblank_mode” and select.
    Press the “edit”
    Type glx to “value” section.
    Save and reboot.

> https://forum.manjaro.org/t/how-to-fix-intel-screen-tearing-on-xfce/31361
