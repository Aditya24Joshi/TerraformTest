resource "azurerm_resource_group" "testRG" {
name = "myRG"
location = "East US"
}

resource "azurerm_virtual_network" "testVNET" {
name = "myVNET"
location = azurerm_resource_group.testRG.location
resource_group_name = azurerm_resource_group.testRG.name
address_space = [ "10.0.0.0/16" ]
}

resource "azurerm_subnet" "testSUBNET"{ 
name = "mySubNet"
resource_group_name = azurerm_resource_group.testRG.name
address_prefixes = [ "10.0.1.0/24" ]
virtual_network_name = azurerm_virtual_network.testVNET.name
}

resource "azurerm_public_ip" "testIP"{
count = 2
name = "testvmip-${count.index}"
resource_group_name = azurerm_resource_group.testRG.name
location = azurerm_resource_group.testRG.location
allocation_method = "Static" 
domain_name_label = "testvmip${random_string.myrandom.id}"  
}

resource "azurerm_network_interface" "testNIC" {
count = 2
name = "myNIC-${count.index}"
location = azurerm_resource_group.testRG.location
resource_group_name = azurerm_resource_group.testRG.name  

ip_configuration {
name = "ipconfig"
subnet_id = azurerm_subnet.testSUBNET.id 
private_ip_address_allocation = "Dynamic"
public_ip_address_id = element(azurerm_public_ip.testvmIP[*].id, count.index) 
}
}


resource "azurerm_windows_virtual_machine" "myvm" {
count = 2
name = "testvm${count.index}"
location = azurerm_resource_group.testRG.location
resource_group_name = azurerm_resource_group.testRG.name
size = "Standard_F2"
admin_username = "aditya"
admin_password = "$tr0ngGuy2494"
network_interface_ids = [element(azurerm_network_interface.testNIC[*].id, count.index)]

os_disk {
name = "os_disk${count.index}" 
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