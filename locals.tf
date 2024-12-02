locals {
  resource_group_name = strcontains(var.linux_function.resource_group, "/resourceGroups/") ? regex("[^\\/]+$", var.linux_function.resource_group) : var.resource_groups[var.linux_function.resource_group].name
  asp                 = strcontains(var.linux_function.asp, "/resourceGroups/") ? var.linux_function.asp : var.asp[var.linux_function.asp]
  storage_account_name = try(var.linux_function.custom_storage_account, null) != null ? module.storage_account[0].name : var.linux_function.storage_account_name
}
