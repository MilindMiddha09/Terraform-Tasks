output "virtual-machine-id" {
    value = azurerm_windows_virtual_machine.vm[*].id
}

output "load-balancer-id" {
    value = azurerm_lb.lb.id
}

output "nsg-id" {
    value = azurerm_network_security_group.vm-nsg.id
}
