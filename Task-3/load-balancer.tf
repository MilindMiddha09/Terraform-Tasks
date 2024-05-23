resource "azurerm_public_ip" "publicip" {
  name                = "${var.prefix}-${var.public-ip-name}"
  location            = azurerm_resource_group.lb-rg.location
  resource_group_name = azurerm_resource_group.lb-rg.name
  allocation_method   = "Static"
  sku = "Standard"
}

resource "azurerm_lb" "lb" {
  name = "${var.prefix}-${var.load-balancer-name}"
  resource_group_name = azurerm_resource_group.lb-rg.name
  location = azurerm_resource_group.lb-rg.location
  sku = "Standard"

  frontend_ip_configuration {
    name                 = "${var.prefix}-${var.frontend-ip-configuration-name}"
    public_ip_address_id = azurerm_public_ip.publicip.id
  }
}

resource "azurerm_lb_backend_address_pool" "backendpool" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = "${var.prefix}-${var.backend-address-pool-name}"
}

resource "azurerm_network_interface_backend_address_pool_association" "example" {
  count = 2
  network_interface_id    = azurerm_network_interface.vmnic[count.index].id
  ip_configuration_name   = "internal"
  backend_address_pool_id = azurerm_lb_backend_address_pool.backendpool.id
}

resource "azurerm_lb_probe" "lb-healthprobe" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = var.health-probe-name
  protocol        = "TCP"
  port            = 80
}

resource "azurerm_lb_rule" "example" {
  loadbalancer_id                = azurerm_lb.lb.id
  name                           = "LBRule"
  protocol                       = "Tcp"
  frontend_port                  = 3389
  backend_port                   = 3389
  frontend_ip_configuration_name = "${var.prefix}-${var.frontend-ip-configuration-name}"
  probe_id                       = azurerm_lb_probe.lb-healthprobe.id
}