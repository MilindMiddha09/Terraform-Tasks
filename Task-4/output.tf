output "aks-id" {
    value = azurerm_kubernetes_cluster.aks.id
}

output "aks-fqdn" {
    value = azurerm_kubernetes_cluster.aks.fqdn
}

output "aks-node-rg" {
    value = azurerm_kubernetes_cluster.aks.node_resource_group
}

output "acr-id" {
    value = azurerm_container_registry.acr.id
}

output "acr-login-server" {
    value = azurerm_container_registry.acr.login_server
}

resource "local_file" "kubeconfig" {
    depends_on = [azurerm_kubernetes_cluster.aks]
    filename = "kubeconfig"
    content = azurerm_kubernetes_cluster.aks.kube_config_raw
}