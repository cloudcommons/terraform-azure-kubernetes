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
