# Infraestructura MonoMap API

Este repositorio contiene la configuración de Terraform para desplegar la infraestructura de MonoMap API.

## Requisitos previos
- Terraform instalado
- Credenciales de Azure configuradas
- Clave SSH generada en ./keys/712mono_server

## Instrucciones de uso

1. Inicializar y validar Terraform:
   ```bash
   terraform init
   terraform validate
   terraform plan
   terraform apply

2. Conectarse a la máquina virtual:
ssh -i ./keys/712mono_server adminuser@<IP_ADDRESS>

3. Destruir la infraestructura cuando ya no se necesite:
    ```bash
    terraform destroy
