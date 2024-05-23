variable "resource-group-name" {
    type = string
    description = "Resource Group Name"
}

variable "location" {
    type = string
    description = "Resource Location"
}

variable "cluster-name" {
    type = string
    description = "Cluster Name in Azure"
}

variable "kubernetes-version" {
    type = string
    description = "Kubernetes Version"
}

variable "system-node-count" {
    type = number
    description = "Number of AKS Worker Nodes"
}

variable "acr-name" {
    type = string
    description = "ACR Name"
}