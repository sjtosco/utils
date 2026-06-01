# Guía de Instalación de Podman en Debian

Guía rápida para instalar y configurar Podman como reemplazo seguro y "rootless" (sin demonio) de Docker, manteniendo compatibilidad con archivos Compose, herramientas externas como VS Code y respetando el firewall del sistema (`gufw`/`ufw`).

## 1. Instalación del Sistema

Instalamos el motor modular de Podman junto con la herramienta oficial de Compose de forma limpia. Usamos `--no-install-recommends` en Compose para evitar la instalación de paquetes redundantes o dependencias innecesarias de Docker.

```bash
# Actualizar los repositorios locales
sudo apt update

# Instalar el motor nativo de Podman y sus dependencias (Netavark, Aardvark, crun)
sudo apt install -y podman

# Instalar Docker Compose oficial de forma limpia
sudo apt install -y --no-install-recommends docker-compose
```

## 2. Activación del Servicio y Automatización de Registros

Habilitamos el socket de comunicación a nivel de usuario y configuramos Docker Hub y Quay.io como buscadores automáticos para que Podman encuentre las imágenes sin necesidad de escribir la ruta completa de los servidores.

```bash
# Iniciar el socket de Podman para el usuario actual (sin sudo)
systemctl --user enable --now podman.socket

# [OPCIONAL] Automatizar búsquedas de imágenes (Evita menús interactivos en nombres cortos)
# Por seguridad (IaC), se recomienda usar nombres calificados (ej: docker.io/library/nginx).
# Si prefieres el comportamiento clásico de Docker, descomenta la siguiente línea:
# sudo bash -c 'echo -e "\nunqualified-search-registries = [\"docker.io\", \"quay.io\"]" >> /etc/containers/registries.conf'
```
*Nota de producción: Por defecto, esta guía adopta la buena práctica de utilizar siempre nombres de imágenes completamente calificados (FQIN), asegurando la portabilidad del código en cualquier servidor.*

## 3. Verificación de la Instalación

Comprueba que el motor básico y la integración de Compose están respondiendo correctamente desde tu usuario común (sin `sudo`):

```bash
# Verificar la versión de Podman instalada
podman --version

# Verificar que Compose detecta el entorno correctamente
podman compose version

# Descargar y ejecutar un contenedor de prueba automatizado
podman run --rm hello-world
```

## 4. Configuración Interna de VS Code

Para evitar configurar variables globales en el archivo `~/.bashrc` de tu sistema operativo, puedes delegar el mapeo del motor y el socket directamente en las preferencias de VS Code (`Ctrl + Shift + P` -> **`Preferences: Open User Settings (JSON)`**).

Copia únicamente las líneas que correspondan a las extensiones que tengas instaladas en tu entorno de desarrollo:

```json
{
  // ====================================================================
  // REQUERIDO PARA: Extensión de Docker (ms-azuretools.vscode-docker)
  // Permite ver y gestionar contenedores/imágenes desde el panel lateral
  // ====================================================================
  "docker.dockerPath": "podman",
  "docker.environment": {
    "DOCKER_HOST": "unix:///run/user/1000/podman/podman.sock"
  },

  // ====================================================================
  // REQUERIDO PARA: Extensión de Dev Containers (ms-vscode-remote.remote-containers)
  // Permite abrir y desarrollar proyectos de código dentro de un contenedor
  // ====================================================================
  "dev.containers.dockerPath": "podman",
  "dev.containers.dockerComposePath": "podman-compose"
}
```

*Nota: Asegúrate de validar tu ID de usuario en la terminal ejecutando el comando `id -u` (por defecto suele ser `1000`) y reemplázalo en la ruta del socket si el tuyo cambia.*

## 5. Uso Diario con Compose

Al utilizar el comando nativo del ecosistema, Podman intercepta el archivo de configuración `.yml` y administra la red interna de forma transparente:

```bash
# Levantar el stack de contenedores en segundo plano
podman compose up -d

# Ver el estado de los servicios levantados
podman compose ps

# Detener y limpiar el entorno creado
podman compose down
```

---

## 💡 Notas Técnicas para Redes y Almacenamiento

### Gestión de Firewall (`gufw` / `ufw`)
A diferencia de Docker (que inyecta sus propias reglas al inicio de Netfilter saltándose las políticas locales), Podman trabaja a nivel de usuario y **sí respeta tu firewall local**. Si bloqueas el tráfico entrante en `gufw`, el contenedor quedará aislado del exterior de forma correcta aunque expongas sus puertos. Deberás abrir explícitamente los puertos en tu firewall cuando quieras que otra máquina de la red acceda al servicio.

### Persistencia de Datos (Volúmenes en Debian)
Debian utiliza **AppArmor** por defecto (no SELinux). Para evitar errores de `Permission denied` en entornos sin root al montar carpetas de tu máquina local dentro del contenedor, añade el modificador `:U` en tus volúmenes. Esto le indica a Podman que debe mapear correctamente de forma recursiva los permisos del propietario en el disco del host:

```yaml
# Ejemplo de montaje seguro en tu archivo docker-compose.yml
services:
  web:
    image: nginx
    ports:
      - "8080:80"
    volumes:
      - ./datos-web:/usr/share/nginx/html:U
```
