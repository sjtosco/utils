## Disable some unused services from evolution (Gnome) on Debian 10

> based on: https://askubuntu.com/questions/480753/remove-evolution-calendar-factory-from-startup

```
sudo chmod -x /usr/lib/evolution/evolution-calendar-factory &&
sudo chmod -x /usr/lib/evolution/evolution-calendar-factory-subprocess &&
sudo chmod -x /usr/lib/evolution/evolution-addressbook-factory &&
sudo chmod -x /usr/lib/evolution/evolution-addressbook-factory-subprocess
```
