module "linux-function-umi" {
  source = "github.com/canada-ca-terraform-modules/terraform-azurerm-caf-user_managed_identity.git?ref=v1.0.0"
  count = try(var.linux_function.create_user_managed_identity, false) ? 1 : 0

  userDefinedString = "${var.userDefinedString}_func_umi"
  env = var.env
  group = var.group
  project = var.project
  umi = { resource_group = var.linux_function.resource_group }
  resource_groups = var.resource_groups
  tags = var.tags
}

resource "azurerm_role_assignment" "umi_sa_contributor" {
    count = length(module.linux-function-umi) == 1 && length(module.storage_account) == 1 ? 1 : 0
  
    role_definition_name = "Storage Blob Data Contributor"
    principal_id = module.linux-function-umi[0].umi-principal-id
    scope = module.storage_account[0].id
}