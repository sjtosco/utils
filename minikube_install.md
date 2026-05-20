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
# ==========================================
# 1. PREPARACIÓN DEL ENTORNO (ROOTLESS)
# ==========================================
# Asegurar que las carpetas locales existan antes de mover archivos
mkdir -p ~/.local/bin
mkdir -p ~/.local/share/bash-completion/completions/

# ==========================================
# 2. INSTALACIÓN DE KUBECTL
# ==========================================
# Instalar el binario de kubectl que ya tienes descargado
install -m 0755 kubectl ~/.local/bin/kubectl

# ==========================================
# 3. INSTALACIÓN DE KUBECOLOR
# ==========================================
# Descargar kubecolor
wget https://github.com/kubecolor/kubecolor/releases/download/v0.6.0/kubecolor_0.6.0_linux_amd64.tar.gz

# Descomprimir el archivo
tar -xvf kubecolor_*.tar.gz

# Instalar el binario en tu carpeta personal con permisos de ejecución
install -m 0755 kubecolor ~/.local/bin/kubecolor

# Limpiar archivos temporales de kubecolor
rm *.tar.gz
rm kubecolor kubectl* LICENSE README.md

# ==========================================
# 4. INSTALACIÓN DE KIND
# ==========================================
# Detectar arquitectura y descargar la versión correcta de Kind (v0.31.0)
[ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.31.0/kind-linux-amd64
[ $(uname -m) = aarch64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.31.0/kind-linux-arm64

# Dar permisos de ejecución e instalar en tu espacio de usuario
install -m 0755 ./kind ~/.local/bin/kind

# Limpiar el binario temporal de kind
rm ./kind

# ==========================================
# 5. GENERACIÓN DE AUTOCOMPLETADOS
# ==========================================
# Generar autocompletado de kubectl
kubectl completion bash > ~/.local/share/bash-completion/completions/kubectl

# Generar el script de autocompletado de kind
kind completion bash > ~/.local/share/bash-completion/completions/kind

# ==========================================
# 6. CONFIGURACIÓN FINAL DE BASH
# ==========================================
# Agregar variables, alias y el autocompletado para el alias al .bashrc
cat << 'EOF' >> ~/.bashrc

# Configuracion de Kubernetes y Kubecolor (Rootless)
export PATH="$HOME/.local/bin:$PATH"
export KUBECOLOR_LIGHT_BACKGROUND=true
alias kubectl="kubecolor"
EOF

# Forzar a Bash a que aplique el mismo autocompletado de kubectl a tu alias "kubecolor"
echo 'complete -F __start_kubectl kubecolor' >> ~/.bashrc

# Recargar tu terminal para aplicar todos los cambios de inmediato
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
