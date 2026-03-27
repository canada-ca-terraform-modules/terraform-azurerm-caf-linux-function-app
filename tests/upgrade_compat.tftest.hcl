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

# Step 1: simulate currently-deployed resource (pre-upgrade inputs)
run "baseline_apply" {
  command = apply

  variables {
    linux_function = {
      resource_group       = "Project"
      asp                  = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg/providers/Microsoft.Web/serverFarms/asp"
      storage_account_name = "mystorageacct"
    }
  }

  assert {
    condition     = azurerm_linux_function_app.linux-function.name == "Dev-SLD-proj-test-func"
    error_message = "Baseline apply: unexpected resource name"
  }
}

# Step 2: plan upgraded code against that state
run "upgrade_plan_no_replacement" {
  command = plan

  variables {
    linux_function = {
      resource_group                         = "Project"
      asp                                    = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg/providers/Microsoft.Web/serverFarms/asp"
      storage_account_name                   = "mystorageacct"
      virtual_network_backup_restore_enabled = false
    }
  }

  assert {
    condition     = azurerm_linux_function_app.linux-function.name == "Dev-SLD-proj-test-func"
    error_message = "Resource name must be unchanged after upgrade"
  }
}
