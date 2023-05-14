resource "azurerm_resource_group" myrg {
name = "testrg"
location = "East US"

}

resource "azurerm_virtual_network" "myvnet" {
name = "testvnet"
address_space = ["10.0.0.0/16"]
location = azurerm_resource_group.myrg.location
resource_group_name = azurerm_resource_group.myrg.name

}

resource "azurerm_subnet" "mysubnet" {
address_prefixes = ["10.0.1.0/24"]
name = "testsubnet"
resource_group_name = azurerm_resource_group.myrg.name 
virtual_network_name = azurerm_virtual_network.myvnet.name
}

resource "azurerm_public_ip" "mypublicip" {
name = "testpub"
location = azurerm_resource_group.myrg.location
resource_group_name = azurerm_resource_group.myrg.name 
allocation_method = "Static" 
domain_name_label = "test${random_string.myrandom.id}"
}

resource "azurerm_network_interface" "mynic" {
name = "testnic"
location = azurerm_resource_group.myrg.location
resource_group_name = azurerm_resource_group.myrg.name

ip_configuration {
  name = "ipconfig"
  subnet_id = azurerm_subnet.mysubnet.id
  private_ip_address_allocation = "Dynamic"
  public_ip_address_id = azurerm_public_ip.mypublicip.id
}
  
}

resource "azurerm_windows_virtual_machine" "myvm" {
name = "testvm"
location = azurerm_resource_group.myrg.location
resource_group_name = azurerm_resource_group.myrg.name
size = "Standard_F2"
admin_username = "aditya"
admin_password = "$tr0ngGuy2494"
network_interface_ids = [azurerm_network_interface.mynic.id]

os_disk {
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