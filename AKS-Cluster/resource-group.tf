resource "azurerm_resource_group" "aks-rg" {
    name = var.resource-group-name
    location = var.location
}