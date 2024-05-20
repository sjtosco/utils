# Nginx Proxy Manager on Proxmox LXC

Create a Alpine LXC. 1 Core - 512MB RAM - 5GB Disk - 0MB SWAP

Repos (`/etc/apk/repositories`):

```
https://dl-cdn.alpinelinux.org/alpine/v3.18/main
https://dl-cdn.alpinelinux.org/alpine/v3.18/community
http://dl-cdn.alpinelinux.org/alpine/edge/main
http://dl-cdn.alpinelinux.org/alpine/edge/community
```

After upgrade, install Docker: 
```
apk add docker dokcer-compose
rc-update add docker boot
service docker start
```

Create `/opt/npm` folder and create inside `docker-compose.yml`:

```
services:
  app:
    image: 'jc21/nginx-proxy-manager:latest'
    restart: unless-stopped
    ports:
      # These ports are in format <host-port>:<container-port>
      - '80:80' # Public HTTP Port
      - '443:443' # Public HTTPS Port
      - '81:81' # Admin Web Port
    # environment:
      # Uncomment this if IPv6 is not enabled on your host
      # DISABLE_IPV6: 'true'

    volumes:
      - ./data:/data
      - ./letsencrypt:/etc/letsencrypt
    healthcheck:
      test: ["CMD", "/usr/bin/check-health"]
      interval: 10s
      timeout: 3s
```


Launch: `docker-compose up -d`. 

Enjoy!
