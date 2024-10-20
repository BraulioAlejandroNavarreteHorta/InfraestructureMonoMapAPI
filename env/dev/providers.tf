terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }

  backend "azurerm" {
    key                  = "terraform.tfstate"
    resource_group_name  = "Blob-RG-BraulioNavarrete"
    storage_account_name = "blobsabraulionavarrete"
    container_name       = "blob-braulionavarrete"
  }
}

provider "azurerm" {
  features {

  }
}

