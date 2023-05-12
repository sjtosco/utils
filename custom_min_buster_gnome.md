# This is an custom "seudo minimal" Debian 10 (Buster) Gnome install

1) Install debian 10 Gnome from [https://cdimage.debian.org/cdimage/unofficial/non-free/cd-including-firmware/10.2.0+nonfree/](https://cdimage.debian.org/cdimage/unofficial/non-free/cd-including-firmware/10.2.0+nonfree/)
2) Enable *sudo* (#/sbin/visudo), enable *contrib* and *non-free* repos and update system  (sudo apt update && sudo apt upgrade -y && sudo apt dist-upgrade -y)
3) Remove some packsges:
    1) sudo apt remove --purge evolution gnome-games gnome-todo
    2) sudo apt remove --purge rhythmbox* gnome-documents gnome-music eog 
    3) sudo apt autoremove
    4) sudo reboot (To reboot system)
4) Install some libraries and usefull utilities:
    1) sudo apt install aria2 gufw linux-headers-$(uname -r) build-essential make automake cmake autoconf git wget gdebi firmware-linux lm-sensors hddtemp xsensors bleachbit hardinfo displaycal && sudo apt install bzip2 zip unzip unace rar unace p7zip p7zip-full p7zip-rar unrar lzip lhasa arj sharutils mpack lzma lzop cabextract python3-pip vim htop ifstat speedtest-cli
    2) sudo apt install ffmpeg libavcodec-extra gstreamer1.0-libav gstreamer1.0-plugins-ugly gstreamer1.0-plugins-bad gstreamer1.0-pulseaudio vorbis-tools vlc libdvd-pkg fonts-freefont-ttf fonts-freefont-otf ttf-bitstream-vera fonts-roboto ttf-mscorefonts-installer openjdk-11-jre icedtea-netx openclipart mplayer mencoder winff obs-studio guvcview&& sudo fc-cache -f -v
    3) sudo dpkg --add-architecture i386 && sudo apt update && sudo apt upgrade -y && sudo apt dist-upgrade -y && sudo apt install wine wine64 wine32 winbind winetricks
    4) sudo apt install gimp gimp-data-extras gimp-dds gimp-gap gimp-gluas gimp-help-es gimp-lensfun gimp-plugin-registry gimp-python gimp-texturize gimp-dcraw inkscape sozi scribus scribus-template glabels fbreader thunderbird thunderbird-l10n-es-ar kolourpaint dia dia-shapes dia-rib-network
    5) sudo apt install gnome-software-plugin-*
5) Install another specific software (from appimage or snap):
    1) Enable flatpak repo Flathub: *flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo*  (After Reboot system)
    2) Openshot / Kdenlive
    3) VSCode
    4) PyCharm
    5) Install and configure virtualenvwrapper:
        1) sudo pip3 install virtualenv virtualenvwrapper
        2) Add to your *~/.bashrc* file:    
        ```bash
        # virtualenv and virtualenvwrapper
        export WORKON_HOME=$HOME/.virtualenvs
        export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
        source /usr/local/bin/virtualenvwrapper.sh
        ```
        3) `source ~/.bashrc`
        
    6) Customize keyboard shortcuts; themes; others
    7) Enjoy!
6) Add support for root GUI.
Create file *wsudo*: `sudo vi /usr/local/bin/wsudo`. Put this content:
```bash
#!/bin/bash 
# -*- ENCODING: UTF-8 -*-
# small script to enable root access to x-windows system
xhost +SI:localuser:root
sudo $1
# disable root acess after application terminates
xhost -SI:localuser:root
# print access status to allow verification that root access was removed
xhost
```
Give file execution permissions: `sudo chmod +x /usr/local/bin/wsudo`

7) sudo apt install texlive-xetex lyx tex4ht ispell ispanish texlive-latex-base texlive-latex-recommended texlive-fonts-extra texlive-lang-spanish texlive-bibtex-extra texlive-pictures preview-latex-style texlive-publishers texlive-fonts-recommended textlive-latex-extra texlive-xetex pandoc lmodern && lyx -x reconfigure

8) 

## Minimize RAM

* sudo chmod -x /usr/lib/evolution/evolution-*

> Based on:
* [https://linuxhint.com/installing_wine_debian_10/](https://linuxhint.com/installing_wine_debian_10/)
* [https://www.diversidadyunpocodetodo.com/debian-buster-10-guia-configuracion-instalacion-software/#7_Repositorio_multimedia_y_codecs_multimedia](https://www.diversidadyunpocodetodo.com/debian-buster-10-guia-configuracion-instalacion-software/#7_Repositorio_multimedia_y_codecs_multimedia)
* [https://www.pyimagesearch.com/2018/05/28/ubuntu-18-04-how-to-install-opencv/](https://www.pyimagesearch.com/2018/05/28/ubuntu-18-04-how-to-install-opencv/)
