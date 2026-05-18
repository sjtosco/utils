# Instalación y Configuración de Podman + Docker-Compose

Guía para instalar un entorno de contenedores moderno, ultra ligero y en modo **Rootless** (sin privilegios de root) en Debian, optimizando el espacio en disco sin instalar herramientas duplicadas de Docker.

## 1. Comandos de Instalación y Configuración

Ejecuta el siguiente bloque en tu terminal:

```bash
# 1. Instalar Podman y el mapeo de usuarios para modo rootless
sudo apt update && sudo apt install -y podman uidmap

# 2. Instalar Compose oficial de forma limpia (evita docker-cli y docker-buildx)
sudo apt install -y --no-install-recommends docker-compose

# 3. Activar el socket por demanda de Podman (consumo 0% en reposo)
systemctl --user enable --now podman.socket

# 4. Enlazar docker-compose con el socket de Podman
echo -e '# podman\nexport DOCKER_HOST="unix://\$XDG_RUNTIME_DIR/podman/podman.sock"' >> ~/.bashrc

# 5. Aplicar cambios en la terminal actual
source ~/.bashrc

# 6. Configurar los repositorios de imágenes por defecto para Podman
sudo short-name-aliases=disabled bash -c 'echo -e "[registries.search]\nregistries = ['\''docker.io'\'', '\''quay.io'\'']" > /etc/containers/registries.conf'

```

## 2. Verificación del Entorno

Para comprobar que el motor de Podman y el orquestador Compose se comunican correctamente, ejecuta:

```bash
# Probar el motor Podman básico
podman run --rm hello-world

# Verificar que Compose esté disponible
docker-compose version
```
