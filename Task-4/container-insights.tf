resource "azurerm_log_analytics_workspace" "container-insights" {
  name                = "aks-container-insights-090802"
  location            = azurerm_resource_group.aks-rg.location
  resource_group_name = azurerm_resource_group.aks-rg.name
  sku                 = "Standard"
  retention_in_days   = 30
}