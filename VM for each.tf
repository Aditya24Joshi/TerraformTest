resource "azurerm_resource_group" "myresourcegroup" {
name = "myRG"
location = "eastus"
}

resource "azurerm_virtual_network" "myvnet" {
name = "myVNET"
location = azurerm_resource_group.myresourcegroup.location
address_space = [ "10.0.0.0/16" ]
resource_group_name = azurerm_resource_group.myresourcegroup.name
}

resource "azurerm_subnet" "mysubnet" {
name = "mySUBNET"
virtual_network_name = azurerm_virtual_network.myvnet.name
address_prefixes = ["10.0.1.0/24"]
resource_group_name = azurerm_resource_group.myresourcegroup.name
}

resource "azurerm_public_ip" "myIP" {
for_each = toset(["vm1","vm2"])
name = "IP-${each.key}"
resource_group_name = azurerm_resource_group.myresourcegroup.name
location = azurerm_resource_group.myresourcegroup.location
allocation_method = "Static"
domain_name_label = "vm-${each.key}-${random_string.myrandom.id}"
}

resource "azurerm_network_interface" "mynic" {
for_each = toset(["vm1", "vm2"])
name = "nic-${each.key}"
location = azurerm_resource_group.myresourcegroup.location
resource_group_name = azurerm_resource_group.myresourcegroup.name

ip_configuration{
name = "internal"
subnet_id = azurerm_subnet.mysubnet.id
private_ip_address_allocation = "Dynamic"
public_ip_address_id = azurerm_public_ip.myIP[each.key].id
}
}

resource "azurerm_windows_virtual_machine" "myvm" {
for_each = azurerm_network_interface.mynic
depends_on = [ azurerm_network_interface.mynic ]
name = "testvm${each.key}"
location = azurerm_resource_group.myresourcegroup.location
resource_group_name = azurerm_resource_group.myresourcegroup.name
size = "Standard_F2"
admin_username = "aditya"
admin_password = "$tr0ngGuy2494"
network_interface_ids = [azurerm_network_interface.mynic[each.key].id]

os_disk {
name = "os_disk${each.key}" 
 caching = "ReadWrite"
 storage_account_type = "Standard_LRS"
}

source_image_reference {
  publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
}
}  





