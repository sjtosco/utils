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

## PAra podman

```
install -m 0755 kubectl ~/.local/bin/kubectl
echo -e '# kubectl\nexport PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
# 1. Descarcar kubecolor
wget https://github.com/kubecolor/kubecolor/releases/download/v0.6.0/kubecolor_0.6.0_linux_amd64.tar.gz
# 2. Descomprimir el archivo (cambia el nombre por el de la versión que bajaste)
tar -xvf kubecolor_*.tar.gz

# 3. Instalar el binario en tu carpeta personal con permisos de ejecución
install -m 0755 kubecolor ~/.local/bin/kubecolor
# 4. Limpiar
rm *.tar.gz
rm kubecolor kubectl* LICENSE README.md

cat << 'EOF' >> ~/.bashrc

# Configuracion de Kubernetes y Kubecolor (Rootless)
export PATH="$HOME/.local/bin:$PATH"
export KUBECOLOR_LIGHT_BACKGROUND=true
EOF

# Generar autocompletado de kubectl
kubectl completion bash > ~/.local/share/bash-completion/completions/kubectl

# Forzar a Bash a que aplique el mismo autocompletado de kubectl a tu alias "kubecolor"
echo 'complete -F __start_kubectl kubecolor' >> ~/.bashrc
source ~/.bashrc

# 1. Detectar arquitectura y descargar la versión correcta de Kind (v0.31.0)
[ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.31.0/kind-linux-amd64
[ $(uname -m) = aarch64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.31.0/kind-linux-arm64

# 2. Asegurar que la carpeta bin local existe
mkdir -p ~/.local/bin

# 3. Dar permisos de ejecución e instalar en tu espacio de usuario (sin sudo)
install -m 0755 ./kind ~/.local/bin/kind

# 4. Limpiar el binario temporal que quedó en la carpeta actual
rm ./kind

# 1. Crear la carpeta de autocompletado para tu usuario si no existe
mkdir -p ~/.local/share/bash-completion/completions/

# 2. Generar el script de autocompletado de kind directamente ahí
kind completion bash > ~/.local/share/bash-completion/completions/kind

# 3. Recargar tu terminal para aplicar los cambios de inmediato
source ~/.bashrc

source ~/.bashrc
```

## Completion and coloring (minikube)

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
