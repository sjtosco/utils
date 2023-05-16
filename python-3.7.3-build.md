# Create custom Python version

This explanation is about custom Python 3.7.3 build in User domain folder. 
**64 bits needed**.

## Prerequisites

```
sudo apt install libssl-dev zlib1g-dev libncurses5-dev libncursesw5-dev libreadline-dev libsqlite3-dev
sudo apt install libgdbm-dev libdb5.3-dev libbz2-dev libexpat1-dev liblzma-dev libffi-dev uuid-dev
sudo apt install tk-dev
```

## Download and locally (USER) install

Create a custom virtualenv, activate it, and install:

```
mkdir Python-3.7.3-x64

wget https://www.python.org/ftp/python/3.7.3/Python-3.7.3.tgz
tar -xvf Python-3.7.3.tgz
cd Python-3.7.3
./configure --prefix=<LOCATION_OF>/Python-3.7.3-x64 --enable-pgo
make -j"$(nproc)"
make install  # If no errors
```
