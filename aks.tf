locals {
  node_resource_group = var.node_resource_group == "" ? "${var.name}-aks-${var.node_pool_name}-${var.location}" : var.node_resource_group
  cluster_subnet_id   = module.vnet.subnets.2.id             // Assuming the cluster subnet is third in the Subnet list
  service_subnet_cidr = module.vnet.subnets.1.address_prefix // Assuming the service subnet is second in the Subnet list
}

resource "azurerm_kubernetes_cluster" "cloudcommons" {
  name                = var.name
  location            = module.resource-group.location
  resource_group_name = module.resource-group.name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version
  node_resource_group = local.node_resource_group

  default_node_pool {
    name                  = var.node_pool_name
    node_count            = var.node_pool_count
    enable_node_public_ip = var.node_public_ip_enable
    vm_size               = var.node_pool_vm_size
    max_pods              = var.node_pool_max_pods
    os_disk_size_gb       = var.node_pool_os_disk_size_gb
    vnet_subnet_id        = local.cluster_subnet_id
    enable_auto_scaling   = var.auto_scaling_enable
    min_count             = var.auto_scaling_min_count
    max_count             = var.auto_scaling_max_count
  }

  linux_profile {
    admin_username = var.linux_admin_username
    ssh_key {
      key_data = var.linux_ssh_key
    }
  }

  network_profile {
    network_plugin     = var.network_plugin
    network_policy     = var.network_policy
    dns_service_ip     = var.network_dns_service
    docker_bridge_cidr = var.network_docker_bridge_cidr
    service_cidr       = local.service_subnet_cidr
    load_balancer_sku  = var.network_load_balancer_sku
  }

  role_based_access_control {
    enabled = var.rbac_enabled
    # azure_active_directory // TODO
  }

  service_principal {
    client_id     = var.client_id
    client_secret = var.client_secret
  }

  addon_profile {
    kube_dashboard {
      enabled = var.kube_dashboard_enabled
    }
  }

  tags = {
    app         = "${var.app}"
    environment = "${var.environment}"
    creator     = "${var.creator}"
  }
}
