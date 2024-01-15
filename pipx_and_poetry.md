# Installation on Debian 12

First ensure: `sudo apt install python3-pip python3-venv`
First, go to user home directory: `cd $HOME`

## pipx

```
sudo apt install pipx --no-install-recommends
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
### Error "Failed to create the collection: Prompt dismissed"

Workaround `export PYTHON_KEYRING_BACKEND=keyring.backends.null.Keyring`.
