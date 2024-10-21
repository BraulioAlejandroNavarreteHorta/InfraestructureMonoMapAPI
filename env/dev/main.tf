module "dev_vm" {
  source                     = "../../modules/vm"
  environment                = "dev"
  mail_secret_key            = var.MAIL_SECRET_KEY
  mail_user                  = var.MAIL_USER
  adminuser                  = "adminuser"
  domain                     = var.DOMAIN
  resourse_group             = "IN-RG-Braulio"
  nic_name                   = "IN-NIC-Braulio"
  mail_service               = var.MAIL_SERVICE
  security_group_name        = "IN-SG-Braulio"
  port                       = var.PORT
  server_name                = "IN-Server-Braulio"
  location                   = "eastus2"
  mapbox_access_token        = var.MAPBOX_ACCESS_TOKEN
  mongo_url                  = var.MONGO_URL
  subnet_name                = "IN-SUBNET-Braulio"
  mongo_initdb_root_username = var.MONGO_INITDB_ROOT_USERNAME
  mongo_initdb_root_password = var.MONGO_INITDB_ROOT_PASSWORD
  mongo_db                   = var.MONGO_DB
  ip_name                    = "IN-IP-Braulio"
  vnet_name                  = "IN-VNET-Braulio"

  # Agregamos las claves SSH
  ssh_private_key            = var.ssh_private_key
  ssh_public_key             = var.ssh_public_key
}

resource "azurerm_resource_group" "RG_BraulioCC" {
  name     = "rc-braulionh"
  location = "eastus2"
}

resource "azurerm_resource_group" "Navarrete" {
  name = "rc-navarrete"
  location = "eastus2"
}
