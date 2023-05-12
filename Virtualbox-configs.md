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
