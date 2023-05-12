# SSH based managed GIT-TEA repo

## Create ssh-rsa key pair
In your PC create (name it as id-rsa-somename):
`ssh-keygen -t rsa -C "your-git-email"`
Save it in ssh-agent>
`ssh-add /route-to/id-rsa-somename`
Copy the /route-to/id-rsa-somename.pub content to the GIT repository

## The right way to clone

git clone ssh://git@ip-or-domain:port/REPOSITORY/DATA-or-INFO.git


> WEB: https://github.com/go-gitea/gitea/issues/9267
