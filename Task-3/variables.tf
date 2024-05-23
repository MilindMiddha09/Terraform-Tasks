variable "resource-group-name" {
    type = string
    description = "Resource Group Name"   
}

variable "location" {
    type = string
    description = "Location of resources"
}

variable "public-ip-name" {
    type = string
    description = "Public IP Address Name"
}

variable "load-balancer-name" {
    type = string
    description = "Load Balancer Name"
}

variable "frontend-ip-configuration-name" {
    type = string
    description = "Frontend IP Configuration Name"
}

variable "backend-address-pool-name" {
    type = string
    description = "Backend Adress Pool Name"
}

variable "prefix" {
    type = string
    description = "Prefix for resource naming."
}

variable "health-probe-name" {
    type = string
    description = "Health Probe Name"
}

variable "frontend-port-name"{
    type = string
    description = "Frontend port name for application gateway"
}

variable "http-setting-name" {
    type = string
    description = "Http setting name"
}

variable "listener-name" {
    type = string
    description = "Listener Name"
}

variable "request-routing-rule-name" {
    type = string
    description = "Request Routing rule name"
}