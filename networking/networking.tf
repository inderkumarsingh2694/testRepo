resource "azurerm_resource_group" "appgrp" {
    name=var.resource_group_name
    location = var.location
}

resource "azurerm_virtual_network" "appnetwork" {
  name = var.virtual_network_name
  location = var.location
  resource_group_name = var.resource_group_name
  address_space = [var.virtual_network_address_space]
  depends_on = [
    azurerm_resource_group.appgrp
  ]
}
resource "azurerm_subnet" "subnetA" {
    name = "appsubnet"
    resource_group_name = var.resource_group_name
    virtual_network_name = var.virtual_network_name
    address_prefixes = [cidrsubnet(var.virtual_network_address_space,8,0)]
    depends_on = [
      azurerm_virtual_network.appnetwork
    ]
}

resource "azurerm_network_security_group" "appnsg" {
        name = "app-nsg"
        location = var.location
        resource_group_name = var.resource_group_name
        security_rule =[ {
        name = "AllowRDP"
        priority = 300
        direction = "Inbound"
        access = "Allow"
        protocol = "Tcp"

        description = "azurerm_network_security_group access rule"

        destination_address_prefixes = [ "*" ]
        destination_application_security_group_ids = [ "*" ]
        destination_port_range = "*"
        destination_port_ranges = [ "*" ]
        destination_address_prefix = "*"

        source_address_prefixes = [ "*" ]
        source_application_security_group_ids = [ "*" ]
        source_port_range = "*"
        source_port_ranges = [ "*" ]
        source_address_prefix = "*"
    } ]

    depends_on = [
      azurerm_virtual_network.appnetwork
    ]
}
resource "azurerm_subnet_network_security_group_association" "appnsg_link" {
  subnet_id = azurerm_subnet.subnetA.id
  network_security_group_id =azurerm_network_security_group.appnsg.id
  depends_on = [
    azurerm_subnet.subnetA,
    azurerm_network_security_group.appnsg
  ]
}