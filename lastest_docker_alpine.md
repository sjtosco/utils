# Docker install on Alpine (latest)

Install Alpine and configure it with `setup-alpine`.

Enable on `/etc/apk/repositories`:

```
https://dl-cdn.alpinelinux.org/alpine/v3.18/main
https://dl-cdn.alpinelinux.org/alpine/v3.18/community
http://dl-cdn.alpinelinux.org/alpine/edge/main
http://dl-cdn.alpinelinux.org/alpine/edge/community
```
Update and install:

```
apk update
apk add docker docker-compose
rc-update add docker boot
service docker start
```
