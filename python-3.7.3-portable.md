# Portable Python 3.7.3

## Download prebuild
If you need a portable Python 3.7.3 for development, download from [Github indygreg repo](https://github.com/indygreg/python-build-standalone/releases/download/20190617/cpython-3.7.3-linux64-20190618T0324.tar.zst), untar and move to `/opt/python/3.7.3` folder (create if not exists)

## Local Build custom

```
cd /opt
sudo wget https://www.python.org/ftp/python/3.7.3/Python-3.7.3.tgz
sudo tar -xvf Python-3.7.3.tgz
sudo rm Python-3.7.3.tgz
sudo chown -R $USER:$USER /opt/Python-3.7.3
cd /opt/Python-3.7.3
./configure --prefix=/opt/Python3.7
make -j4
sudo make install
```
