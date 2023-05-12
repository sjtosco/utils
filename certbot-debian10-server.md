# Install and create certs
```bash
sudo apt install certbot
sudo certbot certonly --standalone --agree-tos --email EMAIL.COM -d DOMAIN.COM
``` 

# Certs location
/etc/letsencrypt/live/$DOMAIN/


# Update certs cockpit
```bash
DOMAIN=YOURDOMAIN.COM
cat /etc/letsencrypt/live/$DOMAIN/fullchain.pem > /etc/cockpit/ws-certs.d/1-my-cert.cert
cat /etc/letsencrypt/live/$DOMAIN/privkey.pem >> /etc/cockpit/ws-certs.d/1-my-cert.cert

systemctl daemon-reload && systemctl restart cockpit.socket
```
# RENEW CRON

https://linuxconfig.org/generate-ssl-certificates-with-letsencrypt-debian-linux





> Other? https://www.digitalocean.com/community/tutorials/how-to-install-cockpit-on-debian-10
