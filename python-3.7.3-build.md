# Create custom Python version

This explanation is about custom Python 3.7.3 build in User domain folder. Base system is Debian 12 Bookworm
**64 bits needed**. In Intel i3 10th Gen took ~3min

> More info: [https://docs.posit.co/resources/install-python-source/](https://docs.posit.co/resources/install-python-source/)

## Prerequisites

```
sudo apt install build-essential cmake linux-headers-amd64
sudo apt-get install libffi-dev libgdbm-dev libsqlite3-dev libssl-dev zlib1g-dev libncurses-dev libreadline-dev tk-dev libc6-dev libbz2-dev
```

Note: Check if `zlib1g-dev` is not installed yet.

## Steps

```
PYTHON_VERSION=3.7.3
curl -O https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz
tar -xvzf Python-${PYTHON_VERSION}.tgz
cd Python-${PYTHON_VERSION}
./configure \
    --prefix=/opt/python/${PYTHON_VERSION} \
    --enable-shared \
    --enable-optimizations \
    --enable-ipv6 \
    --with-ensurepip=install \
    LDFLAGS=-Wl,-rpath=/opt/python/${PYTHON_VERSION}/lib,--disable-new-dtags
make -j"$(nproc)"
sudo make install
```

## Create virtualenv

Create a custom virtualenv, activate it, and install:

```
mkvirtualenv my_custom_venv -p/opt/python/3.7.3/bin/python3
```

### Fix setuptools version

Fix setuptools version: `pip install -U setuptools==58.2`

