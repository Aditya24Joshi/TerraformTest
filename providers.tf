terraform{
required_providers {
azurerm = {
source = "hashicorp/azurerm"
version = ">=3.0"
}
random = {
source ="hashicorp/random"
version = ">=3.0.0"
}
}
}

provider "azurerm"{
tenant_id = "724c6201-042e-4a56-852e-636887bad72f"
subscription_id = "3c891e52-07ee-4dac-b159-2e9e107ae8b0"
client_id = "4c7445ec-7cb0-4ada-a372-b67de96b398d"
client_secret = "P3_8Q~oP3sgCHw2HSVn-f87z5zzxrmfgG4Fhfbhp"
features{}
}

resource "random_string" myrandom {
length = 6
  upper = false 
  special = false
  numeric = false   


}