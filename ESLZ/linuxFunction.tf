variable "linux-functions" {
  description = "Linux Azure functions to deploy"
  type = any
  default = {}
}

module "linux-function" {
  source = "/home/max/devops/modules/terraform-azurerm-caf-linux_function_app"
  for_each = var.linux-functions

  userDefinedString = each.key
  env = var.env
  group = var.group
  project = var.project
  resource_groups = local.resource_groups_all
  linux_function = each.value
  asp = local.asp_id
  subnets = local.subnets
  tags = var.tags
}