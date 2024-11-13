# SSH problems
## "sign_and_send_pubkey: signing failed: agent refused operation"

Fix:

```
chmod 700 ~/.ssh
chmod 600 ~/.ssh/*
```

## Too many authentications

### Simple fix

When you cant connect because you has several SSH keys in `$HOME/.ssh` folder, you can use an SSH option like so:

```
ssh -o PubkeyAuthentication=no pepe@xxx.xxx.xxx.xxx -p 22
```

### Better fix

In `~/.ssh/config`:

```
Hosts *
	IdentitiesOnly=yes
```
