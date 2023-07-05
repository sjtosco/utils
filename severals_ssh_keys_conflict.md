# Simple fix

When you cant connect because you has several SSH keys in `$HOME/.ssh` folder, you can use an SSH option like so:

```
ssh -o PubkeyAuthentication=no pepe@xxx.xxx.xxx.xxx -p 22
```
