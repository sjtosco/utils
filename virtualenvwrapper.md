# Install virtualenvwrapper (workon)
Make sure that you have python3-pip in system.
`sudo pip3 install virtualenv virtualenvwrapper`

# Configuration
In `.bashrc` file add:
```bash
# virtualenv and virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
source /usr/local/bin/virtualenvwrapper.sh
```

## Debian 12 updates

Just install:

```
sudo apt install virtualenvwrapper
```

and copy all above info in .bashrc file except last line. It must be corrected to:
```
source /usr/share/virtualenvwrapper/virtualenvwrapper.sh
```
