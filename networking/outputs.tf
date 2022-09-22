
output "resource_group" {
  value = azurerm_resource_group.appgrp
}

output  "resource_group_name" {
  value = azurerm_resource_group.appgrp.name
}

output "location" {
    value = azurerm_resource_group.appgrp.location
}

output "subnetid" {
    value = azurerm_subnet.subnetA.id
}

output "subnet" {
    value = azurerm_subnet.subnetA
}


