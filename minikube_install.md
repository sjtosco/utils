# Minukube install

Download binary: `curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb`. 
Install: `sudo dpkg -i minikube_latest_amd64.deb`

# Kubectl

```
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
```

If validation is OK, install:
`sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl`

## Completion and coloring

From home folder do...

First: `minikube completion bash > .minikuberc`
Second: `kubectl completion bash > .kubectlrc`

Download new release from: [https://github.com/kubecolor/kubecolor/releases](https://github.com/kubecolor/kubecolor/releases)

Untar, give execution permissions and move binary to `/usr/local/bin` folder.

Add to `.bashrc`:

```
source $HOME/.minikuberc
source $HOME/.kubectlrc
alias kubectl="kubecolor"
```
