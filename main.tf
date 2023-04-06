terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.99.0"
    }
  }
}

provider "azurerm" {
tenant_id = "724c6201-042e-4a56-852e-636887bad72f"
subscription_id = "3c891e52-07ee-4dac-b159-2e9e107ae8b0"
client_id = "4c7445ec-7cb0-4ada-a372-b67de96b398d"
client_secret = "P3_8Q~oP3sgCHw2HSVn-f87z5zzxrmfgG4Fhfbhp"
features {}
}

#Create Resource Group
resource "azurerm_resource_group" "tamops" {
  name     = "tamops"
  location = "eastus2"
}

resource "azurerm_virtual_network" "storagevnet" {
  name                = "storagevnet"
  address_space       = ["10.0.0.0/16"]
  location            = "eastus2"
  resource_group_name = "tamops"
}

resource "azurerm_subnet" "storagesubnet" {
  name                 = "storagesubnet"
  resource_group_name  = "tamops"
  virtual_network_name = "storagevnet"
  address_prefixes     = ["10.0.2.0/24"]
  service_endpoints    = ["Microsoft.Sql", "Microsoft.Storage"]
}

resource "azurerm_storage_account" "samplestorageacc" {
  name                = "samplestorageacc"
  resource_group_name = "tamops"

  location                 = "eastus2"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  network_rules {
    default_action             = "Deny"
    ip_rules                   = ["100.0.0.1"]
    virtual_network_subnet_ids = [azurerm_subnet.storagesubnet.id]
  }

}
