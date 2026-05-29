mock_provider "azurerm" {}
mock_provider "http" {}

variables {
  env               = "Dev"
  group             = "SLD"
  project           = "proj"
  userDefinedString = "test"
  resource_groups   = { Project = { name = "rg-test", location = "canadacentral" } }
  subnets           = {}
  tags              = {}
  asp               = { asp = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg/providers/Microsoft.Web/serverFarms/asp" }
}

run "naming_convention" {
  command = plan

  variables {
    linux_function = {
      resource_group       = "Project"
      asp                  = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg/providers/Microsoft.Web/serverFarms/asp"
      storage_account_name = "mystorageacct"
    }
  }

  assert {
    condition     = azurerm_linux_function_app.linux-function.name == "Dev-SLD-proj-test-func"
    error_message = "Name must follow {env}-{group}-{project}-{userDefinedString}-func convention"
  }
}

run "default_values" {
  command = plan

  variables {
    linux_function = {
      resource_group       = "Project"
      asp                  = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg/providers/Microsoft.Web/serverFarms/asp"
      storage_account_name = "mystorageacct"
    }
  }

  assert {
    condition     = azurerm_linux_function_app.linux-function.https_only == true
    error_message = "https_only must default to true"
  }

  assert {
    condition     = azurerm_linux_function_app.linux-function.public_network_access_enabled == false
    error_message = "public_network_access_enabled must default to false"
  }

  assert {
    condition     = azurerm_linux_function_app.linux-function.functions_extension_version == "~4"
    error_message = "functions_extension_version must default to ~4"
  }
}

run "virtual_network_backup_restore_enabled" {
  command = plan

  variables {
    linux_function = {
      resource_group                         = "Project"
      asp                                    = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg/providers/Microsoft.Web/serverFarms/asp"
      storage_account_name                   = "mystorageacct"
      virtual_network_backup_restore_enabled = true
    }
  }

  assert {
    condition     = azurerm_linux_function_app.linux-function.virtual_network_backup_restore_enabled == true
    error_message = "virtual_network_backup_restore_enabled must be settable"
  }
}
