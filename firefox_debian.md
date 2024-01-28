# Firefox and Debian 12

Create `/etc/environment.d/23firefox.conf`:

```
MOZ_ENABLE_WAYLAND=1
```

> https://bbs.archlinux.org/viewtopic.php?id=258954

## Install latest Firefox Stable in Debian

## From firefox oficial repo (Preferred)

> [Oficial firefox web instructions](https://support.mozilla.org/en-US/kb/install-firefox-linux#w_install-firefox-deb-package-for-debian-based-distributions)

```
sudo install -d -m 0755 /etc/apt/keyrings
wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null
```

Check The fingerprint should be 35BAA0B33E9EB396F59CA838C0BA5CE6DC6315A3:

```
gpg -n -q --import --import-options import-show /etc/apt/keyrings/packages.mozilla.org.asc | awk '/pub/{getline; gsub(/^ +| +$/,""); print "\n"$0"\n"}' 
```

Add repo and install

```
echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | sudo tee -a /etc/apt/sources.list.d/mozilla.list > /dev/null

echo '
Package: *
Pin: origin packages.mozilla.org
Pin-Priority: 1000
' | sudo tee /etc/apt/preferences.d/mozilla

sudo apt-get update && sudo apt-get install firefox
```


## Manual 
* First download from [Official Web](https://www.mozilla.org/es-ES/firefox/new/).

* Second uncompress, move and give right permissions: `tar xfv firefox-*.tar.bz2 && sudo mv firefox /opt/ && sudo chmod 755 -R /opt/firefox`.
* Create launcher: `/usr/share/applications/firefox.desktop`:

```
[Desktop Entry]
Name=Firefox
Comment=Web Browser
Exec=/opt/firefox/firefox %u
Terminal=false
Type=Application
Icon=/opt/firefox/browser/chrome/icons/default/default128.png
Categories=Network;WebBrowser;
MimeType=text/html;text/xml;application/xhtml+xml;application/xml;application/vnd.mozilla.xul+xml;application/rss+xml;application/rdf+xml;image/gif;image/jpeg;image/png;x-scheme-handler/http;x-scheme-handler/https;
StartupNotify=true
Actions=Private;

[Desktop Action Private]
Exec=/opt/firefox/firefox --private-window %u
Name=Open in private mode
```

* Link for use from terminal: `sudo ln -s /opt/firefox/firefox /usr/local/bin/firefox`.

* Set manually installed Firefox as the default DebianAlternatives browser (x-www-browser): `sudo update-alternatives --install /usr/bin/x-www-browser x-www-browser /opt/firefox/firefox 200 && sudo update-alternatives --set x-www-browser /opt/firefox/firefox`.

* Remove Firefox-ESR: `sudo apt remove --purge firefox-esr && sudo apt autoremove --purge && rm -r $HOME/.mozilla`.
* Enjoy!

## Using deb

Download correct deb from this [github repo](https://github.com/degaart/firefox-user-installer.git); install it and enjoy!
