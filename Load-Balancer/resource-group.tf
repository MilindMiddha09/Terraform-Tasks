resource "azurerm_resource_group" "lb-rg"{
    name = "${var.prefix}-${var.resource-group-name}"
    location = var.location
}