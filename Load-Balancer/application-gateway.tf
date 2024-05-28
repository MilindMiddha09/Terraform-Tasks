
resource "azurerm_application_gateway" "app-gateway" {
  name                = "${var.prefix}-appgateway"
  resource_group_name = azurerm_resource_group.lb-rg.name
  location            = azurerm_resource_group.lb-rg.location

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "my-gateway-ip-configuration"
    subnet_id = azurerm_subnet.internal.id
  }

  frontend_port {
    name = var.frontend-port-name
    port = 80
  }

  frontend_ip_configuration {
    name                 = var.frontend-ip-configuration-name
    public_ip_address_id = azurerm_public_ip.publicip.id
  }

  backend_address_pool {
    name = var.backend-address-pool-name.name
  }

  backend_http_settings {
    name                  = var.http-setting-name
    cookie_based_affinity = "Disabled"
    path                  = "/path1/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = var.listener-name
    frontend_ip_configuration_name = var.frontend-ip-configuration-name
    frontend_port_name             = var.frontend-port-name
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = var.request-routing-rule-name
    priority                   = 9
    rule_type                  = "Basic"
    http_listener_name         = var.listener-name
    backend_address_pool_name  = var.backend-address-pool-name
    backend_http_settings_name = var.http-setting-name
  }
}

resource "azurerm_network_interface_application_gateway_backend_address_pool_association" "app-gateway-backend-pool-association" {
  count                   = var.vm-count
  network_interface_id    = azurerm_network_interface.vmnic[count.index].id
  ip_configuration_name   = "internal"
  backend_address_pool_id = tolist(azurerm_application_gateway.app-gateway.backend_address_pool).0.id
}