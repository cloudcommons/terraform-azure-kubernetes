module "rg" {
  source      = "cloudcommons/resource-group/azure"
  version     = "0.1.0"
  name        = "${var.resource_group}-${var.environment}"
  location    = var.location
  app         = var.app
  creator     = var.creator
  environment = var.environment
}
