# (My) Recommended GNS3 simulator on Debian 9

## Dependencies
```
sudo apt install qemu-kvm dynamips bridge-utils libvirt-dev
cd Descargas
git clone git://github.com/GNS3/ubridge.git
cd ubridge
make 
sudo make install
```
## Installing using pip3

```bash
pip3 install gns3-server gns3-gui pyqt5
```
## And...

It's all. You can now from Terminal launch **gns3** or you can make a launcher from GUI (using alacarte or similar)
Logo can be downloaded from Internet ;-)

## NAT 
[https://adm935.blogspot.com/2017/09/error-while-setting-up-node-virbr0-is.html](https://adm935.blogspot.com/2017/09/error-while-setting-up-node-virbr0-is.html)

Regards!
