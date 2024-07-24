# Virtualbox advanced configs

## Shared folder

> WEB: https://askubuntu.com/questions/456400/why-cant-i-access-a-shared-folder-from-within-my-virtualbox-machine

First you need to install Guest Additions (although I already did this during the installation).

1. Start your VM
2. Devices > Insert Guest Additions CD image...
3. I had to manually mount the CD: sudo mount /dev/cdrom /media/cdrom
4. Install the necessary packages: sudo apt-get install make gcc linux-headers-$(uname -r)
5. Install the Guest Additions: sudo /media/cdrom/VBoxLinuxAdditions.run

Now, for temporal mount point: 
```bash
mkdir ~/new
sudo mount -t vboxsf New ~/new
```

For permanent:

In /etc/fstab add this line:
`New /home/user/new vboxsf defaults 0 0`

## Nested virtualization on Intel

On intel can't enable nested virtuallization from GUI. So, open terminal and do (ie. VM named "myVM"):

```
VBoxManage modifyvm myVM --nested-hw-virt on
```

## VM shrink for export

> [https://web.archive.org/web/20170215174752/http://dantwining.co.uk/2011/07/18/how-to-shrink-a-dynamically-expanding-guest-virtualbox-image/](https://web.archive.org/web/20170215174752/http://dantwining.co.uk/2011/07/18/how-to-shrink-a-dynamically-expanding-guest-virtualbox-image/); [https://www.enmimaquinafunciona.com/pregunta/79075/reducir-el-tamano-del-archivo-ova-en-virtualbox](https://www.enmimaquinafunciona.com/pregunta/79075/reducir-el-tamano-del-archivo-ova-en-virtualbox)

* Install: `sudo apt install zerofree`.
* Reboot the machine (sudo shutdown -r now). During boot, hold down the left shift key. A menu will appear, you need to select "recovery mode"; this should be the second item in the list.
* Run df and look for the mount point that's that the biggest – this is where all your files are, and is the one we'll need to run zerofree against. For the rest of this guide, we'll assume it's /dev/sda1.
* The following three commands (thanks, VirtualBox forum!) stop background services that we can't have running:
  * `service rsyslog stop && service network-manager stop && pkill dhclient`.
* Once they’ve stopped, you can re-mount the partition as readonly (zerofree needs this): `mount -n -o remount,ro -t ext3 /dev/sda1 /`
* You can now run zerofree: `zerofree -v /dev/sda1`.
* Shut down the VM: `shutdown -h now`.
* You can shrink the image in-place (on Host) with the following command: `VBoxManage modifyhd my.vdi --compact`. You must replace my.vdi with the name of the vdi you'd like to shrink (located on `VirtualBox VMs` folder).
* Finally, export from Virtualbox GUI interface to Movilive.ova. 

