resource "azurerm_network_interface" "vmnic" {
  count = 2
  name                = "${var.prefix}-nic${count.index}"
  location            = azurerm_resource_group.lb-rg.location
  resource_group_name = azurerm_resource_group.lb-rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "example" {
  count = 2
  name                = "${var.prefix}-vm-${count.index}"
  resource_group_name = azurerm_resource_group.lb-rg.name
  location            = azurerm_resource_group.lb-rg.location
  size                = "Standard_DS1_v2"
  admin_username      = "azuser"
  admin_password      = "Azure@090802"
  network_interface_ids = [
    azurerm_network_interface.vmnic[count.index].id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}

resource "azurerm_virtual_machine_extension" "ps_script" {
  count                      = 2
  name                       = "${azurerm_windows_virtual_machine.vm[count.index].name}-wsi-${count.index}"
  virtual_machine_id         = azurerm_windows_virtual_machine.vm[count.index].id
  publisher                  = "Microsoft.Compute"
  type                       = "CustomScriptExtension"
  type_handler_version       = "1.9"

  settings = <<SETTINGS
    {
      "commandToExecute": "powershell -encodedCommand ${textencodebase64(file("${path.module}/setup.ps1"), "UTF-16LE")}"
    }
  SETTINGS
}