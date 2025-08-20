# Fix missing over amplification Debian 13

> https://forum.endeavouros.com/t/i-just-figured-out-how-to-turn-on-overamplification-in-gnome-to-put-the-volumes-above-100-natively/53429

```
gsettings set org.gnome.desktop.sound allow-volume-above-100-percent ‘true’
```
