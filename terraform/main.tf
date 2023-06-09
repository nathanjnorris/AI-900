data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "default" {
  name     = "rg-mlw-tst"
  location = var.location
}