# Azure AKS Setup

This project contains the Terraform configuration files to set up an Azure Kubernetes Service (AKS) cluster. It includes a GitHub Actions pipeline for continuous integration and deployment.

## Prerequisites

- Azure account with necessary permissions
- GitHub account
- Terraform installed locally (for local testing)

## Configuration

The Terraform configuration is defined under several files:

- `main.tf`: Contains the main configuration for Azure resources including the AKS cluster.
- `variables.tf`: Defines the variables used in the configuration.
- `terraform.tfvars`: Contains the values for the defined variables.

### Azure Provider Setup

The Azure provider is configured with necessary credentials:

```hcl
provider "azurerm" {
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}
