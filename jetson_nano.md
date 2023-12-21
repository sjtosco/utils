# Jetson nano 4G RAM model

Download image from [Qengineering github](https://github.com/Qengineering/Jetson-Nano-Ubuntu-20-image). 
Or [Direct link](https://ln5.sync.com/dl/403a73c60/bqppm39m-mh4qippt-u5mhyyfi-nnma8c4t). Tested with update 2023-09-17.
Write it to SD Card (minimun 32GB, **64GB recomended**). 
Expand Filesystem using GParted.
Connect via wired LAN network: `ssh jetson@nano.local`. Default password is *jetson*.


## Upgrade

`sudo apt update && sudo apt upgrade -y`

## Utils (Misc)

`sudo apt install ifstat`

## Wifi

Support some adapters.

## RDP

```
sudo apt install xrdp
sudo systemctl enable xrdp
sudo systemctl set-default multi-user.target
sudo reboot
```

> Note: Desktop GUI is disabled. If you need it, you can enable with: `sudo systemctl set-default graphical.target`.

For remove the "Authentication Required to Create Managed Color Device", you can create a proper PolKit file: 
`sudo vi /etc/polkit-1/localauthority/50-local.d/45-allow-colord.pkla`:

```
[Allow Colord all Users]
Identity=unix-user:*
Action=org.freedesktop.color-manager.create-device;org.freedesktop.color-manager.create-profile;org.freedesktop.color-manager.delete-device;org.freedesktop.color-manager.delete-profile;org.freedesktop.color-manager.modify-device;org.freedesktop.color-manager.modify-profile
ResultAny=no
ResultInactive=no
ResultActive=yes
```
## Virtualenv and virtualenvwrapper

Install `sudo pip3 install virtualenv virtualenvwrapper`

Add to `~/.bashrc`

```
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
source /usr/local/bin/virtualenvwrapper.sh
```
Finally `source ~/.bashrc`.

## Bibliography

* [https://youtu.be/7-WMvmWVxJQ?si=tleu05Vos9IfNgN4](https://youtu.be/7-WMvmWVxJQ?si=tleu05Vos9IfNgN4) 
* [https://raspberry-valley.azurewebsites.net/NVIDIA-Jetson-Nano/#nvidia-jetson-nano](https://raspberry-valley.azurewebsites.net/NVIDIA-Jetson-Nano/#nvidia-jetson-nano)
