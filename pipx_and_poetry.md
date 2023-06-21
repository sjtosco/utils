# Installation on Debian 12

First ensure: `sudo apt install python3-pip`
First, go to user home directory: `cd $HOME`

## pipx

```
sudo apt install pipx
pipx ensurepath
```
Follow `pipx completions` instructions.

## poetry

```
pipx install poetry
poetry completions bash >> ~/.poetryrc
```

Add to `$HOME/.bashrc`:

```
# Poetry
source $HOME/.poetryrc
```
