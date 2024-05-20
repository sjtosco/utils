# Wireguard VPN on Proxmox LXC

Create a Debian LXC: 1 Core - 512MG RAM - 8GB Disk - 0MB SWAP
Upgrade system nad install docker-ce engine from [web](https://docs.docker.com/engine/install/debian/).

Create folder `/opt/wg-easy`. Inside place two files:

Compose file: `docker-compose.yml`

```
volumes:
  etc_wireguard:

services:
  wg-easy:
    environment:
      # Change Language:
      # (Supports: en, ua, ru, tr, no, pl, fr, de, ca, es, ko, vi, nl, is, pt, chs, cht, it, th, hi)
      - LANG=en
      # Required:
      # Change this to your host's public address
      - WG_HOST=wg.XXXXXXXXXXX

      # Optional:
      - PASSWORD=XXXXXXXXX
      # - PORT=51821
      # - WG_PORT=51820
      # - WG_DEFAULT_ADDRESS=10.8.0.x
      - WG_DEFAULT_DNS=XXXXXXXXXXXX
      # - WG_MTU=1420
      # - WG_ALLOWED_IPS=192.168.15.0/24, 10.0.1.0/24
      # - WG_PERSISTENT_KEEPALIVE=25
      # - WG_PRE_UP=echo "Pre Up" > /etc/wireguard/pre-up.txt
      # - WG_POST_UP=echo "Post Up" > /etc/wireguard/post-up.txt
      # - WG_PRE_DOWN=echo "Pre Down" > /etc/wireguard/pre-down.txt
      # - WG_POST_DOWN=echo "Post Down" > /etc/wireguard/post-down.txt
      - UI_TRAFFIC_STATS=true
      - UI_CHART_TYPE=2 # (0 Charts disabled, 1 # Line chart, 2 # Area chart, 3 # Bar chart)

    image: ghcr.io/wg-easy/wg-easy
    container_name: wg-easy
    volumes:
      - etc_wireguard:/etc/wireguard
    ports:
      - "51820:51820/udp"
      - "51821:51821/tcp"
    restart: unless-stopped
    cap_add:
      - NET_ADMIN
      - SYS_MODULE
    sysctls:
      - net.ipv4.ip_forward=1
      - net.ipv4.conf.all.src_valid_mark=1
```

Update container bash: `update.sh`

```
#!/usr/bin/env bash

docker stop wg-easy
docker rm wg-easy
docker pull ghcr.io/wg-easy/wg-easy
docker compose up -d
```

Launch `docker compose up -d`.

Create cert using: [http://wg.pve.lan:81] (Accessible only from LAN / VPN)

Enjoy!
