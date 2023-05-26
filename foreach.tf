resource "azurerm_resource_group" "myrg" {
for_each = toset(["eastus", "westus", "centralindia"])
name = "${each.value}-rg"
location = each.key
}