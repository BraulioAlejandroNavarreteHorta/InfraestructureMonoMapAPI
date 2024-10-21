
# Infraestructura MonoMap API

Este repositorio contiene la configuración de Terraform para desplegar la infraestructura de MonoMap API.

## Requisitos previos
- Terraform instalado
- Credenciales de Azure configuradas
- Clave SSH generada en `./keys/712mono_server`

### Instalación de Terraform

Si no tienes Terraform instalado, puedes seguir estos pasos para instalarlo:

1. Descargar Terraform:
   ```bash
   curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
   sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
   sudo apt-get update && sudo apt-get install terraform
   ```

2. Verificar la instalación:
   ```bash
   terraform -version
   ```

### Configuración de Credenciales de Azure

1. Instalar Azure CLI:
   ```bash
   curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
   ```

2. Iniciar sesión en tu cuenta de Azure:
   ```bash
   az login
   ```

3. Configurar la suscripción:
   ```bash
   az account set --subscription "<ID_DE_LA_SUSCRIPCIÓN>"
   ```

### Generar Clave SSH

1. Crear una clave SSH para acceder a la máquina virtual:
   ```bash
   ssh-keygen -t rsa -b 4096 -f ./keys/712mono_server
   ```

2. Asegúrate de que el archivo de la clave SSH esté disponible en la ruta `./keys/712mono_server`.

## Instrucciones de uso

1. Inicializar y validar Terraform:
   ```bash
   terraform init
   terraform validate
   terraform plan
   terraform apply
   ```

2. Conectarse a la máquina virtual:
   ```bash
   ssh -i ./keys/712mono_server adminuser@<IP_ADDRESS>
   ```

3. Destruir la infraestructura cuando ya no se necesite:
   ```bash
   terraform destroy
   ```

## Estructura del Proyecto

- **`.github/workflows/`**: Contiene los archivos de workflows para GitHub Actions.
  - `deploy.dev.yml`: Workflow que despliega la infraestructura automáticamente al realizar un commit y push en la rama principal.
  - `destroy.dev.yml`: Workflow que destruye la infraestructura manualmente desde GitHub Actions.
  
- **`env/dev/`**: Definición del entorno de desarrollo para Terraform y Docker.
  - `containers/`: Definición de los contenedores Docker utilizados en el proyecto.
    - `docker-compose.yml`: Archivo que describe los servicios de Docker que serán levantados (incluye los contenedores y la red necesaria).
  - `main.tf`, `providers.tf`, `variables.tf`: Archivos de configuración de Terraform para definir los recursos necesarios en el entorno de desarrollo.

- **`modules/vm/`**: Módulo de Terraform que define la creación de las máquinas virtuales (VMs).
  - `scripts/`: Scripts utilizados para la configuración de las VMs.
  - `main.tf`, `outputs.tf`, `providers.tf`, `variables.tf`: Archivos que configuran la infraestructura relacionada con las VMs, como proveedores, variables y outputs.

- **`.gitignore`**: Configuración para excluir archivos sensibles y no necesarios del control de versiones. Está basado en las mejores prácticas para proyectos que utilizan Terraform.

## Requisitos

- Tener instalado [Terraform](https://www.terraform.io/downloads.html).
- Tener instalado [Docker](https://www.docker.com/products/docker-desktop/).
- Tener una cuenta de GitHub configurada y acceso al repositorio.

## Instrucciones para Ejecutar Localmente

1. Clonar el repositorio:

   ```bash
   git clone <URL_REPOSITORIO>
   cd infraestructura-monomap-api
   ```

2. Ejecutar los contenedores Docker definidos en `docker-compose.yml`:

   ```bash
   cd env/dev/containers
   docker-compose up -d
   ```

   Esto levantará los servicios necesarios para el desarrollo local.

3. Configurar los providers y variables de Terraform en `env/dev`:

   - Asegúrate de que los archivos `.tfvars` necesarios para las variables sensibles (como contraseñas o claves API) estén correctamente configurados, ya que no están incluidos en el control de versiones.

4. Inicializar Terraform:

   ```bash
   terraform init
   ```

5. Planificar y aplicar los cambios para desplegar la infraestructura local:

   ```bash
   terraform plan
   terraform apply
   ```

   Esto creará los recursos definidos en los archivos `.tf` del entorno local.

## Despliegue Automático

El proceso de despliegue de la infraestructura está automatizado con GitHub Actions. Al realizar un commit y push a la rama principal, el workflow `deploy.dev.yml` se ejecutará y desplegará la infraestructura definida.

- **Despliegue**: Cada vez que haces un commit y push, el workflow de `deploy.dev.yml` automáticamente aplica los cambios de Terraform para desplegar la infraestructura en el entorno de desarrollo.
- **Destrucción Manual**: Para destruir la infraestructura, debes ejecutar el workflow `destroy.dev.yml` directamente desde la interfaz de GitHub Actions. Al hacer clic en el botón de ejecución, se destruirán los recursos.

## Detener la Infraestructura

1. Para destruir los recursos desplegados, ve a la pestaña "Actions" en tu repositorio de GitHub.
2. Selecciona el workflow `destroy.dev.yml`.
3. Haz clic en el botón "Run workflow" para ejecutar el proceso de destrucción de la infraestructura.

Esto ejecutará el comando `terraform destroy` para eliminar todos los recursos creados en el entorno de desarrollo.
