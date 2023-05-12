> https://stackoverflow.com/questions/30383845/what-is-the-best-practice-of-docker-ufw-under-ubuntu
> 
## Solving UFW and Docker issues

create /etc/docker/daemon.json file with content as follows:

```json
{
  "iptables": false
}

```
and reboot (or sudo service docker restart)
