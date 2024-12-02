module "storage_account" {
  source = "github.com/canada-ca-terraform-modules/terraform-azurerm-caf-storage_accountV2.git?ref=v1.0.5"
  count = try(var.linux_function.custom_storage_account, null) != null ? 1 : 0
  userDefinedString    = "${var.userDefinedString}-func-sa"
  location             = var.location
  env                  = var.env
  resource_groups      = var.resource_groups
  subnets              = var.subnets
  private_dns_zone_ids = null
  tags                 = var.tags
  storage_account = {
    resource_group            = var.linux_function.resource_group
    account_tier              = "Standard"
    account_replication_type  = "GRS"
    private_endpoint = {
      "func" = {                       
        resource_group    = var.linux_function.custom_storage_account.resource_group
        subnet            = var.linux_function.custom_storage_account.subnet     
        subresource_names = ["blob"]  
      }
    }
  }
}