resource "azurerm_resource_group" "myrg" {
for_each {
dcapp = "eastus"
dcapp1 = "westus"
dcapp2 = "centralindia"
}
name = "${each.key}-rg"
location = each.value
  
}