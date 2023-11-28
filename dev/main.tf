provider "azurerm" {
  subscription_id = "${var.subscription_id}"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  tenant_id       = "${var.tenant_id}"
  version         =  "1.43"
}

resource "azurerm_resource_group" "group_dev" {
  name     = "${var.prefix}-resource-group"
  location = var.location
}

resource "azurerm_virtual_network" "network_dev" {
  name                = "${var.prefix}-network"
  resource_group_name = "${azurerm_resource_group.group_dev.name}"
  location            = var.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet_1" {
  name                 = "${var.prefix}-subnet"
  virtual_network_name = "${azurerm_virtual_network.network_dev.name}"
  resource_group_name  = "${azurerm_resource_group.group_dev.name}"
  address_prefix       = "10.0.1.0/24"
}

resource "azurerm_kubernetes_cluster" "clusterdev" {
  name                  = "${var.prefix}-aks"
  location              = var.location
  resource_group_name   = "${azurerm_resource_group.group_dev.name}"
  dns_prefix            = "${var.prefix}-aks"

  default_node_pool {
    name            = "pooldev"
    node_count      = "1"
    vm_size         = "Standard_B2s"
    os_disk_size_gb = "30"
  }

  service_principal {
    client_id     = var.kubernetes_client_id
    client_secret = var.kubernetes_client_secret
  }

  tags = {
    Environment = "dev"
  }
}
