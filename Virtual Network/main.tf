provider "azurerm" {
  version = "~> 2.0"
  features {}
}

resource "azurerm_resource_group" "rg" {
  name = "${var.name}-rg"
  location = var.location

  tags = {
    environment = var.environment
  }

}

resource "azurerm_network_security_group" "sg_frontend" {
  name = "${var.name}-sg_frontend"
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_network_security_group" "sg_backend" {
  name = "${var.name}-sg_backend"
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_virtual_network" "vn" {
  name = "${var.name}-vn"
  address_space = ["10.0.0.0/16"]
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  subnet {
    name = "${var.name}-subnet-frontend"
    address_prefix = "10.0.1.0/24"
    security_group = azurerm_network_security_group.sg_frontend.id
  }

  subnet {
    name = "${var.name}-subnet-backend"
    address_prefix = "10.0.2.0/24"
    security_group = azurerm_network_security_group.sg_backend.id
  }

  tags = azurerm_resource_group.rg.tags

}