# Set qt theme in gnome desktop

Install `sudo apt install qt5ct qt5-style-plugins`.

In `$HOME/.profile` append:

```
export QT_STYLE_OVERRIDE=qt5ct
export QT_QPA_PLATFORMTHEME=qt5ct
```
Configure *Qt5 Setting* app ans close session.
