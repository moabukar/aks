provider "azurerm" {
  subscription_id = "9c87ae58-f043-4631-94a6-9e8f9519132a"
  client_id       = "700cec46-0b61-4ab7-8dfb-fe59c532a84c"
  client_secret   = "punD]wyXBE=X?:1D7QZw952DuB=W2@Ms"
  tenant_id       = "76a2ae5a-9f00-4f6b-95ed-5d33d77c4d61"
}

resource "azurerm_resource_group" "group_prod" {
  name     = "${var.prefix}-resource-group"
  location = var.location
}

resource "azurerm_virtual_network" "network_prod" {
  name                = "${var.prefix}-network"
  resource_group_name = "${azurerm_resource_group.group_prod.name}"
  location            = var.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet_1" {
  name                 = "${var.prefix}-subnet"
  virtual_network_name = "${azurerm_virtual_network.network_prod.name}"
  resource_group_name  = "${azurerm_resource_group.group_prod.name}"
  address_prefix       = "10.0.1.0/24"
}

resource "azurerm_kubernetes_cluster" "clusterprod" {
  name                = "${var.prefix}-aks"
  location            = var.location
  resource_group_name = "${azurerm_resource_group.group_prod.name}"
  dns_prefix          = "${var.prefix}-aks"

  default_node_pool {
    name            = "poolprod"
    node_count      = "1"
    vm_size         = "Standard_B2s"
    os_disk_size_gb = "30"
  }

  service_principal {
    client_id     = var.kubernetes_client_id
    client_secret = var.kubernetes_client_secret
  }

  tags = {
    Environment = "prod"
  }
}
