# Use git with several custom certificates

When use one certificate, and it's named `id_rsa` and `id_rsa.pub` all is ok when you use git protocol (using git over ssh instead https).
But when you use several repos, with diferents identities, maybe you have a problem.
This is a possible solution, use an git alias command that masquerade the custom certificate, diferent the `id_rsa` one.

# Custom alias

In `$HOME/.bashrc` add this line:

```
alias git-2="GIT_SSH_COMMAND='ssh -i $HOME/.ssh/id_rsa2.pub -o IdentitiesOnly=yes' git"
```

Of course, you can change alias and cert names according yours.
