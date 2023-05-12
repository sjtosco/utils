# Proxmox quick tips

## Disable No-subscription-promt
> Based on: [https://johnscs.com/remove-proxmox51-subscription-notice/](https://johnscs.com/remove-proxmox51-subscription-notice/)

Simple:

```
cd /usr/share/javascript/proxmox-widget-toolkit
cp proxmoxlib.js proxmoxlib.js.bak
vi proxmoxlib.js
```
Search and replace : "Ext.Msg.show" by "void". Save and exit.
Restart service: `systemctl restart pveproxy.service`

If problems, just restore `proxmoxlib.js.bak` and restart service. ;-)
