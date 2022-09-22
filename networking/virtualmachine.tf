resource "azurerm_network_interface" "appinterface" {
  name = "appinterface"
  location = var.location
  resource_group_name = var.resource_group_name
  
  ip_configuration {
    name = "internal"
    subnet_id = azurerm_subnet.subnetA.id
    private_ip_address_allocation = "Dynamic"
  }
  depends_on = [
    azurerm_subnet.subnetA
  ]
}
resource "azurerm_windows_virtual_machine" "appvm" {
    name = "appvm"
    resource_group_name = var.resource_group_name
    location = var.location
    size = "Standard_D2s_v3"
    admin_username = "adminuser"
    admin_password = "admin@1234"
    network_interface_ids = [
        azurerm_network_interface.appinterface.id
    ]
    os_disk {
      caching = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }
    source_image_reference {
      publisher = "MicrosoftWindowsServer"
      offer= "WindowsServer"
      sku="2019-Datacenter"
      version="latest"
    }
    depends_on = [
        azurerm_network_interface.appinterface,
      azurerm_resource_group.appgrp
    ]
  
}
  