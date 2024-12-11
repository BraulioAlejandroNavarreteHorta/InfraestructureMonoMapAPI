# Infraestructura BranchTicket API

Este repositorio contiene la configuración de Terraform para desplegar la infraestructura del sistema de gestión de tickets para sucursales.

## Requisitos previos
- Terraform instalado
- Credenciales de Azure configuradas
- Clave SSH generada en `./keys/branch_ticket_server`

### Instalación de Terraform

Si no tienes Terraform instalado, puedes seguir estos pasos para instalarlo:

```bash
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install terraform
```

Verificar la instalación:
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
ssh-keygen -t rsa -b 4096 -f ./keys/branch_ticket_server
```

2. Asegúrate de que el archivo de la clave SSH esté disponible en la ruta `./keys/branch_ticket_server`.

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
ssh -i ./keys/branch_ticket_server adminuser@<IP_ADDRESS>
```

3. Destruir la infraestructura cuando ya no se necesite:
```bash
terraform destroy
```

## Estructura del Proyecto

- **`.github/workflows/`**: Contiene los archivos de workflows para GitHub Actions.
  - `deploy.branch.yml`: Workflow que despliega la infraestructura automáticamente al realizar un commit y push en la rama principal.
  - `destroy.branch.yml`: Workflow que destruye la infraestructura manualmente desde GitHub Actions.
  
- **`env/branch/`**: Definición del entorno de sucursales para Terraform y Docker.
  - `containers/`: Definición de los contenedores Docker utilizados en el proyecto.
    - `docker-compose.yml`: Archivo que describe los servicios de Docker (incluye los contenedores para la API de tickets, base de datos, y sistema de colas).
  - `main.tf`, `providers.tf`, `variables.tf`: Archivos de configuración de Terraform para definir los recursos necesarios en el entorno de sucursales.

- **`modules/branch-system/`**: Módulo de Terraform que define la infraestructura para el sistema de tickets.
  - `scripts/`: Scripts utilizados para la configuración del sistema.
    - `init-db.sh`: Script para inicializar la base de datos de tickets
    - `queue-setup.sh`: Script para configurar el sistema de colas
  - `main.tf`, `outputs.tf`, `providers.tf`, `variables.tf`: Archivos que configuran la infraestructura del sistema de tickets.

## Requisitos

- Tener instalado [Terraform](https://www.terraform.io/downloads.html)
- Tener instalado [Docker](https://www.docker.com/products/docker-desktop/)
- Tener una cuenta de GitHub configurada y acceso al repositorio

## Instrucciones para Ejecutar Localmente

1. Clonar el repositorio:

```bash
git clone <URL_REPOSITORIO>
cd infraestructura-branch-ticket-api
```

2. Ejecutar los contenedores Docker definidos en `docker-compose.yml`:

```bash
cd env/branch/containers
docker-compose up -d
```

Esto levantará los servicios necesarios para el sistema de tickets.

3. Configurar los providers y variables de Terraform en `env/branch`:

- Asegúrate de que los archivos `.tfvars` necesarios para las variables sensibles estén correctamente configurados.

4. Inicializar Terraform:

```bash
terraform init
```

5. Planificar y aplicar los cambios para desplegar la infraestructura:

```bash
terraform plan
terraform apply
```

## Despliegue Automático

El proceso de despliegue está automatizado con GitHub Actions:

- **Despliegue**: El workflow `deploy.branch.yml` se ejecuta automáticamente al hacer push a la rama principal.
- **Destrucción Manual**: Utiliza el workflow `destroy.branch.yml` desde la interfaz de GitHub Actions para destruir la infraestructura.

## Detener la Infraestructura

1. Ve a la pestaña "Actions" en el repositorio de GitHub.
2. Selecciona el workflow `destroy.branch.yml`.
3. Ejecuta el workflow para destruir la infraestructura.

Esto eliminará todos los recursos creados en el entorno de sucursales.

## Notas Adicionales

- Cada sucursal tiene su propia instancia de base de datos para gestionar tickets locales
- El sistema incluye una cola de mensajes para sincronización entre sucursales
- Se implementa un sistema de caché para optimizar consultas frecuentes
- Los logs se centralizan en un servicio de monitoreo
