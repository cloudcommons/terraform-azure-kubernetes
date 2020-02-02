output "id" {
  description = "The Kubernetes Managed Cluster ID."  
  value       = azurerm_kubernetes_cluster.cloudcommons.id
}

output "fqdn" {
  description = "The FQDN of the Azure Kubernetes Managed Cluster."  
  value       = azurerm_kubernetes_cluster.cloudcommons.fqdn
}

output "kube_admin_config" {
  description = "A kube_admin_config block as defined below. This is only available when Role Based Access Control with Azure Active Directory is enabled."  
  value       = azurerm_kubernetes_cluster.cloudcommons.kube_admin_config
  sensitive   = true
}

output "kube_admin_config_raw" {
  description = "Raw Kubernetes config for the admin account to be used by kubectl and other compatible tools. This is only available when Role Based Access Control with Azure Active Directory is enabled."
  value       = azurerm_kubernetes_cluster.cloudcommons.kube_admin_config_raw
  sensitive   = true  
}

output "kube_config" {
  description = "Cluster Kubernetes Configuration object"  
  value       = azurerm_kubernetes_cluster.cloudcommons.kube_config
  sensitive   = true
}

output "kube_config_raw" {
  description = "Cluster Kubernetes Configuration raw file"
  value       = azurerm_kubernetes_cluster.cloudcommons.kube_config_raw
  sensitive   = true  
}

output "node_resource_group" {
  description = "The auto-generated Resource Group which contains the resources for this Managed Kubernetes Cluster."
  value       = azurerm_kubernetes_cluster.cloudcommons.node_resource_group
}
