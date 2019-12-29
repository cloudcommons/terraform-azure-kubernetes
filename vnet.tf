module "vnet" {
  source         = "cloudcommons/vnet/azure"
  version        = "0.1.0"
  name           = var.name
  location       = var.location
  resource_group = var.resource_group
  address_space  = var.vnet_address_space
  dns_servers    = var.vnet_dns_servers
  nsg_enabled    = var.vnet_nsg_enabled
  ddos_enabled   = var.vnet_ddos_enabled
  subnets        = var.vnet_subnets
}