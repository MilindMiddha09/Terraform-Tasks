resource "azurerm_kubernetes_cluster" "aks" {
    name = var.cluster-name
    kubernetes_version = var.kubernetes-version
    location = var.location
    resource_group_name = azurerm_resource_group.aks-rg.name
    dns_prefix = var.cluster-name

    oms_agent{
        log_analytics_workspace_id = azurerm_log_analytics_workspace.container-insights.id
    }

    default_node_pool {
        name = "system"
        node_count = var.system-node-count
        vm_size = "Standard_DS2_v2"
        type = "VirtualMachineScaleSets"
        zones = [1,3]
        enable_auto_scaling = false
    }

    identity {
        type = "SystemAssigned"
    }

    network_profile {
        load_balancer_sku = "standard"
        network_plugin = "kubenet"
    }
}



# az acr import --name myacr32423 --source docker.io/library/nginx:latest --image nginx:v1
# az aks get-credentials --resource-group aks-rg --name my-aks-cluster