provider "azurerm" {
  version = "~> 2.0"
  features {}
}

resource "azurerm_resource_group" "rg" {
  name = var.name
  location = var.location

  tags = {
    environment = var.environment
  }

}