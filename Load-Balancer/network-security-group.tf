resource "azurerm_network_security_group" "vm-nsg" {
  name                = "${var.prefix}-nsg"
  location            = azurerm_resource_group.lb-rg.location
  resource_group_name = azurerm_resource_group.lb-rg.name

  security_rule {
    name                       = "Http"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface_security_group_association" "nic-nsg" {
  count                     = var.vm-count
  network_interface_id      = azurerm_network_interface.vmnic[count.index].id
  network_security_group_id = azurerm_network_security_group.vm-nsg.id
}