resource "azurerm_container_registry" "acr"{
    name = var.acr-name
    resource_group_name = azurerm_resource_group.aks-rg.name
    location = var.location
    sku = "Standard"
    admin_enabled = false
}

resource "azurerm_role_assignment" "role-assignment" {
  principal_id                     = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true
}