variable "linux-functions" {
  description = "Linux Azure functions to deploy"
  type = any
  default = {}
}

module "linux-function" {
  source = "github.com/canada-ca-terraform-modules/terraform-azurerm-caf-linux-function-app.git?ref=v1.0.0"
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