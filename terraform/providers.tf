terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
  backend "azurerm" {
      resource_group_name  = "rg-terraform"
      storage_account_name = "stterraformsvc"
      container_name       = "tfstate"
      key                  = "$env:ARM_ACCOUNT_KEY"
  }
}

provider "azurerm" {
  features {}
}