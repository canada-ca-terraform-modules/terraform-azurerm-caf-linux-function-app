locals {
  resource_group_name = strcontains(var.linux_function.resource_group, "/resourceGroups/") ? regex("[^\\/]+$", var.linux_function.resource_group) : var.resource_groups[var.linux_function.resource_group].name
  asp                 = strcontains(var.linux_function.asp, "/resourceGroups/") ? var.linux_function.asp : var.asp[var.linux_function.asp]
  storage_account_name = try(var.linux_function.custom_storage_account, null) != null ? module.storage_account[0].name : var.linux_function.storage_account_name
  subnet_id = try(var.linux_function.virtual_network_subnet_id, null) != null ?  strcontains(var.linux_function.virtual_network_subnet_id, "/resourceGroups/") ? var.linux_function.virtual_network_subnet_id : var.subnets[var.linux_function.virtual_network_subnet_id].id : null

  // Just to reduce the try calls
  create_user_managed_identity = try(var.linux_function.create_user_managed_identity, false)

  identity = (
    // if identity is provided, merge created identity with it
    try(var.linux_function.identity, null) != null 
      ? [{
          type = (
            local.create_user_managed_identity 
              ? (
                strcontains(var.linux_function.identity.type, "SystemAssigned") 
                  ? "SystemAssigned, UserAssigned" 
                  : "UserAssigned" 
                )
              : var.linux_function.identity.type
          )

          identity_ids = (
            local.create_user_managed_identity 
              ? concat(
                try(var.linux_function.identity.identity_ids, []),
                [ module.linux-function-umi[0].umi-id ]
              )
              : try(var.linux_function.identity.identity_ids, [])
          )
      }] 
      // else if identity not provided, use created identity
      : (
        local.create_user_managed_identity ? [{
          type = "UserAssigned"
          identity_ids = [ module.linux-function-umi[0].umi-id ]
        }] 
        // else, no identity
        : []
      )
  )
}
