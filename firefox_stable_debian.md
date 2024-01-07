# Install latest Firefox Stable in Debian

## Manual (Preferred)
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
