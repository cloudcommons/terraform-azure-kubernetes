provider "azurerm" {
  version = "~> 2.0"
  features {}
}

provider "kubernetes" {
  version                = "= 1.10"
  # load_config_file       = false
  host                   = azurerm_kubernetes_cluster.cloudcommons.kube_config.0.host
  client_certificate     = base64decode(azurerm_kubernetes_cluster.cloudcommons.kube_config.0.client_certificate)
  client_key             = base64decode(azurerm_kubernetes_cluster.cloudcommons.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.cloudcommons.kube_config.0.cluster_ca_certificate)
}
