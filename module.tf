resource "azurerm_linux_function_app" "linux-function" {
  name                = local.func-name
  location            = var.location
  resource_group_name = local.resource_group_name
  service_plan_id     = local.asp

  app_settings                                   = merge(
                                                      { 
                                                        "AZURE_CLIENT_ID" = try(module.linux-function-umi[0].umi-client-id, null),
                                                        "WEBSITE_LOAD_ROOT_CERTIFICATES" = try(var.linux_function.inject_root_cert, false) ? "8EBD38E4D2A40158C4CA179E791D239D7F520F0A" : null,
                                                      },
                                                      try(var.linux_function.app_settings, {}), # from the caller, allow overriding of the client id
                                                  )
  builtin_logging_enabled                        = try(var.linux_function.builtin_logging_enabled, true)
  client_certificate_enabled                     = try(var.linux_function.client_certificate_enabled, false)
  client_certificate_mode                        = try(var.linux_function.client_certificate_mode, "Optional")
  client_certificate_exclusion_paths             = try(var.linux_function.client_certificate_exclusion_paths, null)
  daily_memory_time_quota                        = try(var.linux_function.daily_memory_time_quota, 0)
  enabled                                        = try(var.linux_function.enabled, true)
  content_share_force_disabled                   = try(var.linux_function.content_share_force_disabled, false)
  functions_extension_version                    = try(var.linux_function.functions_extension_version, "~4")
  ftp_publish_basic_authentication_enabled       = try(var.linux_function.ftp_publish_basic_authentication_enabled, false)
  https_only                                     = try(var.linux_function.https_only, true)
  public_network_access_enabled                  = try(var.linux_function.public_network_access_enabled, false)
  key_vault_reference_identity_id                = try(var.linux_function.key_vault_reference_identity_id, null)
  storage_account_access_key                     = try(var.linux_function.storage_account_access_key, null)
  storage_account_name                           = local.storage_account_name
  storage_uses_managed_identity                  = (
                                                      # if we are creating the managed identity and custom storage,
                                                      # we are also giving it access to the storage
                                                      try(var.linux_function.create_user_managed_identity, false) && try(var.linux_function.custom_storage_account, null) != null
                                                      ? true : try(var.linux_function.storage_uses_managed_identity, null)
                                                    )
  storage_key_vault_secret_id                    = try(var.linux_function.storage_key_vault_secret_id, null)
  virtual_network_subnet_id                      = local.subnet_id
  webdeploy_publish_basic_authentication_enabled = try(var.linux_function.webdeploy_publish_basic_authentication_enabled, true)
  vnet_image_pull_enabled                        = try(var.linux_function.vnet_image_pull_enabled, true)
  zip_deploy_file                                = try(var.linux_function.zip_deploy_file, null)

  tags = merge(try(var.linux_function.tags, {}), var.tags)

  site_config {
    always_on                                     = try(var.linux_function.site_config.always_on, true)
    api_definition_url                            = try(var.linux_function.site_config.api_definition_url, null)
    api_management_api_id                         = try(var.linux_function.site_config.api_management_api_id, null)
    app_command_line                              = try(var.linux_function.site_config.app_command_line, null)
    app_scale_limit                               = try(var.linux_function.app_scale_limit, null)
    application_insights_connection_string        = try(var.linux_function.application_insights_connection_string, null)
    application_insights_key                      = try(var.linux_function.site_config.application_insights_key, null)
    container_registry_managed_identity_client_id = try(var.linux_function.site_config.container_registry_managed_identity_client_id, null)
    container_registry_use_managed_identity       = try(var.linux_function.site_config.container_registry_use_managed_identity, null)
    default_documents                             = try(var.linux_function.site_config.default_documents, null)
    elastic_instance_minimum                      = try(var.linux_function.site_config.elastic_instance_minimum, null)
    ftps_state                                    = try(var.linux_function.site_config.ftps_state, "Disabled")
    health_check_path                             = try(var.linux_function.site_config.health_check_path, null)
    health_check_eviction_time_in_min             = try(var.linux_function.site_config.health_check_eviction_time_in_min, null)
    http2_enabled                                 = try(var.linux_function.site_config.http2_enabled, false)
    ip_restriction_default_action                 = try(var.linux_function.site_config.ip_restriction_default_action, "Allow")
    load_balancing_mode                           = try(var.linux_function.site_config.load_balancing_mode, "LeastRequests")
    managed_pipeline_mode                         = try(var.linux_function.site_config.managed_pipeline_mode, "Integrated")
    minimum_tls_version                           = try(var.linux_function.site_config.minimum_tls_version, "1.2")
    pre_warmed_instance_count                     = try(var.linux_function.site_config.pre_warmed_instance_count, null)
    remote_debugging_enabled                      = try(var.linux_function.site_config.remote_debugging_enabled, false)
    remote_debugging_version                      = try(var.linux_function.site_config.remote_debugging_version, null)
    runtime_scale_monitoring_enabled              = try(var.linux_function.site_config.runtime_scale_monitoring_enabled, false)
    scm_ip_restriction_default_action             = try(var.linux_function.site_config.scm_ip_restriction_default_action, "Allow")
    scm_minimum_tls_version                       = try(var.linux_function.site_config.scm_minimum_tls_version, "1.2")
    scm_use_main_ip_restriction                   = try(var.linux_function.site_config.scm_use_main_ip_restriction, false)
    use_32_bit_worker                             = try(var.linux_function.site_config.use_32_bit_worker, false)
    vnet_route_all_enabled                        = try(var.linux_function.site_config.vnet_route_all_enabled, false)
    websockets_enabled                            = try(var.linux_function.site_config.websockets_enabled, false)
    worker_count                                  = try(var.linux_function.site_config.worker_count, null)

    dynamic "application_stack" {
      for_each = try(var.linux_function.site_config.application_stack, null) != null ? [1] : []
      content {
        dynamic "docker" {
          for_each = try(var.linux_function.site_config.application_stack.docker, {})
          content {
            registry_url      = docker.value.registry_url
            image_name        = docker.value.image_name
            image_tag         = docker.value.image_tag
            registry_username = try(docker.value.registry_username, null)
            registry_password = try(docker.value.registry_password, null)
          }
        }
        dotnet_version              = try(var.linux_function.site_config.application_stack.dotnet_version, null)
        use_dotnet_isolated_runtime = try(var.linux_function.site_config.application_stack.use_dotnet_isolated_runtime, null)
        java_version                = try(var.linux_function.site_config.application_stack.java_version, null)
        node_version                = try(var.linux_function.site_config.application_stack.node_version, null)
        python_version              = try(var.linux_function.site_config.application_stack.python_version, null)
        powershell_core_version     = try(var.linux_function.site_config.application_stack.powershell_core_version, null)
        use_custom_runtime          = try(var.linux_function.site_config.application_stack.use_custom_runtime, null)
      }
    }

    dynamic "app_service_logs" {
      for_each = try(var.linux_function.site_config.app_service_logs, {})
      content {
        disk_quota_mb         = try(app_service_logs.value.disk_quota_mb, 35)
        retention_period_days = try(app_service_logs.value.retention_period_days, null)
      }
    }

    dynamic "cors" {
      for_each = try(var.linux_function.site_config.cors, {})
      content {
        allowed_origins     = try(cors.value.allowed_origins, null)
        support_credentials = try(cors.value.support_credentials, false)
      }
    }

    dynamic "ip_restriction" {
      for_each = try(var.linux_function.site_config.ip_restriction, {})
      content {
        action                    = try(ip_restriction.value.action, "Deny")
        ip_address                = try(ip_restriction.value.ip_address, null)
        name                      = try(ip_restriction.value.name, null)
        priority                  = try(ip_restriction.value.priority, null)
        service_tag               = try(ip_restriction.value.service_tag, null)
        virtual_network_subnet_id = try(ip_restriction.value.virtual_network_subnet_id, null)
        description               = try(ip_restriction.value.description, null)
        dynamic "headers" {
          for_each = try(ip_restriction.value.headers, {})
          content {
            x_azure_fdid      = try(headers.value.x_azure_fdid, null)
            x_fd_health_probe = try(headers.value.x_fd_health_probe, null)
            x_forwarded_for   = try(headers.value.x_forwarded_for, null)
            x_forwarded_host  = try(headers.value.x_forwarded_host, null)
          }
        }
      }
    }

    dynamic "scm_ip_restriction" {
      for_each = try(var.linux_function.site_config.scm_ip_restriction, {})
      content {
        action                    = try(scm_ip_restriction.value.action, "Deny")
        ip_address                = try(scm_ip_restriction.value.ip_address, null)
        name                      = try(scm_ip_restriction.value.name, null)
        priority                  = try(scm_ip_restriction.value.priority, null)
        service_tag               = try(scm_ip_restriction.value.service_tag, null)
        virtual_network_subnet_id = try(scm_ip_restriction.value.virtual_network_subnet_id, null)
        description               = try(scm_ip_restriction.value.description, null)
        dynamic "headers" {
          for_each = try(scm_ip_restriction.value.headers, {})
          content {
            x_azure_fdid      = try(headers.value.x_azure_fdid, null)
            x_fd_health_probe = try(headers.value.x_fd_health_probe, null)
            x_forwarded_for   = try(headers.value.x_forwarded_for, null)
            x_forwarded_host  = try(headers.value.x_forwarded_host, null)
          }
        }
      }
    }
  }

  dynamic "auth_settings" {
    for_each = try(var.linux_function.auth_settings, {})
    content {
      enabled                        = auth_settings.value.enabled
      additional_login_parameters    = try(auth_settings.value.additional_login_parameters, null)
      allowed_external_redirect_urls = try(auth_settings.value.allowed_external_redirect_urls, null)
      default_provider               = try(auth_settings.value.default_provider, null)
      issuer                         = try(auth_settings.value.issuer, null)
      runtime_version                = try(auth_settings.value.runtime_version, null)
      token_refresh_extension_hours  = try(auth_settings.value.token_refresh_extension_hours, 72)
      token_store_enabled            = try(auth_settings.value.token_store_enabled, false)
      unauthenticated_client_action  = try(auth_settings.value.unauthenticated_client_action, null)

      dynamic "active_directory" {
        for_each = try(auth_settings.value.active_directory, {})
        content {
          client_id                  = active_directory.value.client_id
          allowed_audiences          = try(active_directory.value.allowed_audiences, null)
          client_secret              = try(active_directory.value.client_secret, null)
          client_secret_setting_name = try(active_directory.value.client_secret_setting_name, null)
        }
      }
      dynamic "facebook" {
        for_each = try(auth_settings.value.facebook, {})
        content {
          app_id                  = facebook.value.app_id
          app_secret              = try(facebook.value.app_secret, null)
          app_secret_setting_name = try(facebook.value.app_secret_setting_name, null)
          oauth_scopes            = try(facebook.value.oauth_scopes, null)
        }
      }
      dynamic "github" {
        for_each = try(auth_settings.value.github, {})
        content {
          client_id                  = github.value.client_id
          client_secret              = try(github.value.client_secret, null)
          client_secret_setting_name = try(github.value.client_secret_setting_name, null)
          oauth_scopes               = try(github.value.oauth_scopes, null)
        }
      }
      dynamic "google" {
        for_each = try(auth_settings.value.google, {})
        content {
          client_id                  = google.value.client_id
          client_secret              = try(google.value.client_secret, null)
          client_secret_setting_name = try(google.value.client_secret_setting_name, null)
          oauth_scopes               = try(google.value.oauth_scopes, null)
        }
      }
      dynamic "microsoft" {
        for_each = try(auth_settings.value.microsoft, {})
        content {
          client_id                  = microsoft.value.client_id
          client_secret              = try(microsoft.value.client_secret, null)
          client_secret_setting_name = try(microsoft.value.client_secret_setting_name, null)
          oauth_scopes               = try(microsoft.value.oauth_scopes, null)
        }
      }
      dynamic "twitter" {
        for_each = try(auth_settings.value.twitter, {})
        content {
          consumer_key                 = twitter.value.consumer_key
          consumer_secret              = try(twitter.value.consumer_secret, null)
          consumer_secret_setting_name = try(twitter.value.consumer_secret_setting_name, null)
        }
      }
    }
  }

  dynamic "auth_settings_v2" {
    for_each = try(var.linux_function.auth_settings, {})
    content {
      auth_enabled                            = try(auth_settings_v2.value.auth_enabled, false)
      runtime_version                         = try(auth_settings_v2.value.runtime_version, "~1")
      config_file_path                        = try(auth_settings_v2.value.config_file_path, null)
      require_authentication                  = try(auth_settings_v2.value.require_authentication, null)
      unauthenticated_action                  = try(auth_settings_v2.value.unauthenticated_action, null)
      default_provider                        = try(auth_settings_v2.value.default_provider, null)
      excluded_paths                          = try(auth_settings_v2.value.excluded_paths, null)
      require_https                           = try(auth_settings_v2.value.require_https, true)
      http_route_api_prefix                   = try(auth_settings_v2.value.http_route_api_prefix, null)
      forward_proxy_convention                = try(auth_settings_v2.value.forward_proxy_convention, "NoProxy")
      forward_proxy_custom_host_header_name   = try(auth_settings_v2.value.forward_proxy_custom_host_header_name, null)
      forward_proxy_custom_scheme_header_name = try(auth_settings_v2.value.forward_proxy_custom_scheme_header_name, null)

      login {
        logout_endpoint                   = try(auth_settings_v2.value.login.logout_endpoint, null)
        token_store_enabled               = try(auth_settings_v2.value.login.token_store_enabled, false)
        token_refresh_extension_time      = try(auth_settings_v2.value.login.token_refresh_extension_time, 72)
        token_store_path                  = try(auth_settings_v2.value.login.token_store_path, null)
        token_store_sas_setting_name      = try(auth_settings_v2.value.login.token_store_sas_setting_name, null)
        preserve_url_fragments_for_logins = try(auth_settings_v2.value.login.preserve_url_fragments_for_logins, false)
        allowed_external_redirect_urls    = try(auth_settings_v2.value.login.allowed_external_redirect_urls, null)
        cookie_expiration_convention      = try(auth_settings_v2.value.login.cookie_expiration_convention, null)
        cookie_expiration_time            = try(auth_settings_v2.value.login.cookie_expiration_time, "08:00:00")
        validate_nonce                    = try(auth_settings_v2.value.login.validate_nonce, true)
        nonce_expiration_time             = try(auth_settings_v2.value.login.nonce_expiration_time, "00:05:00")
      }

      dynamic "apple_v2" {
        for_each = try(auth_settings_v2.value.apple_v2, {})
        content {
          client_id                  = apple_v2.value.client_id
          client_secret_setting_name = apple_v2.value.client_secret_setting_name
          login_scopes               = try(apple_v2.value.login_scopes, null)
        }
      }

      dynamic "active_directory_v2" {
        for_each = try(auth_settings_v2.value.active_directory_v2, {})
        content {
          client_id                            = active_directory_v2.value.client_id
          tenant_auth_endpoint                 = active_directory_v2.value.tenant_auth_endpoint
          client_secret_setting_name           = try(active_directory_v2.value.client_secret_setting_name, null)
          client_secret_certificate_thumbprint = try(active_directory_v2.value.client_secret_certificate_thumbprint, null)
          jwt_allowed_groups                   = try(active_directory_v2.value.jwt_allowed_groups, null)
          jwt_allowed_client_applications      = try(active_directory_v2.value.jwt_allowed_client_applications, null)
          www_authentication_disabled          = try(active_directory_v2.value.www_authentication_disabled, false)
          allowed_groups                       = try(active_directory_v2.value.allowed_groups, null)
          allowed_identities                   = try(active_directory_v2.value.allowed_identities, null)
          allowed_applications                 = try(active_directory_v2.value.allowed_applications, null)
          allowed_audiences                    = try(active_directory_v2.value.allowed_audiences, null)
          login_parameters                     = try(active_directory_v2.value.login_parameters, null)
        }
      }

      dynamic "azure_static_web_app_v2" {
        for_each = try(auth_settings_v2.value.azure_static_web_app_v2, {})
        content {
          client_id = azure_static_web_app_v2.value.client_id
        }
      }

      dynamic "custom_oidc_v2" {
        for_each = try(auth_settings_v2.value.custom_oidc_v2, {})
        content {
          name                          = custom_oidc_v2.value.name
          client_id                     = custom_oidc_v2.value.client_id
          openid_configuration_endpoint = custom_oidc_v2.value.openid_configuration_endpoint
          name_claim_type               = try(custom_oidc_v2.value.name_claim_type, null)
          scopes                        = try(custom_oidc_v2.value.scopes, null)
          client_credential_method      = try(custom_oidc_v2.value.client_credential_method, null)
          client_secret_setting_name    = try(custom_oidc_v2.value.client_secret_setting_name, null)
          authorisation_endpoint        = try(custom_oidc_v2.value.authorisation_endpoint, null)
          token_endpoint                = try(custom_oidc_v2.value.token_endpoint, null)
          issuer_endpoint               = try(custom_oidc_v2.value.issuer_endpoint, null)
          certification_uri             = try(custom_oidc_v2.value.certification_uri, null)
        }
      }

      dynamic "facebook_v2" {
        for_each = try(auth_settings_v2.value.facebook_v2, {})
        content {
          app_id                  = facebook_v2.value.app_id
          app_secret_setting_name = facebook_v2.value.app_secret_setting_name
          graph_api_version       = try(facebook_v2.value.graph_api_version, null)
          login_scopes            = try(facebook_v2.value.login_scopes, null)
        }
      }

      dynamic "github_v2" {
        for_each = try(auth_settings_v2.value.github_v2, {})
        content {
          client_id                  = github_v2.value.client_id
          client_secret_setting_name = github_v2.value.client_secret_setting_name
          login_scopes               = try(github_v2.value.login_scopes, null)
        }
      }

      dynamic "google_v2" {
        for_each = try(auth_settings_v2.value.google_v2, {})
        content {
          client_id                  = google_v2.value.client_id
          client_secret_setting_name = google_v2.value.client_secret_setting_name
          allowed_audiences          = try(google_v2.value.allowed_audiences, null)
          login_scopes               = try(google_v2.value.login_scopes, null)
        }
      }

      dynamic "microsoft_v2" {
        for_each = try(auth_settings_v2.value.microsoft_v2, {})
        content {
          client_id                  = microsoft_v2.value.client_id
          client_secret_setting_name = microsoft_v2.value.client_secret_setting_name
          allowed_audiences          = try(microsoft_v2.value.allowed_audiences, null)
          login_scopes               = try(microsoft_v2.value.login_scopes, null)
        }
      }

      dynamic "twitter_v2" {
        for_each = try(auth_settings_v2.value.twitter_v2, {})
        content {
          consumer_key                 = twitter_v2.value.consumer_key
          consumer_secret_setting_name = twitter_v2.value.consumer_secret_setting_name
        }
      }
    }
  }

  dynamic "backup" {
    for_each = try(var.linux_function.backup, {})
    content {
      name                = backup.key
      storage_account_url = backup.value.storage_account_url
      enabled             = try(backup.value.enabled, true)

      schedule {
        frequency_interval       = backup.value.schedule.frequency_interval
        frequency_unit           = backup.value.schedule.frequency_unit
        keep_at_least_one_backup = try(backup.value.schedule.keep_at_least_one_backup, false)
        retention_period_days    = try(backup.value.schedule.retention_period_days, 30)
        start_time               = try(backup.value.schedule.start_time, null)
      }
    }
  }

  dynamic "connection_string" {
    for_each = try(var.linux_function.connection_string, {})
    content {
      name  = connection_string.key
      type  = connection_string.value.type
      value = connection_string.value.value
    }
  }

  dynamic "identity" {
    for_each = try(var.linux_function.create_user_managed_identity, false) ? [{
      type = "UserAssigned"
      identity_ids = [ module.linux-function-umi[0].umi-id ]
    }] : try(var.linux_function.identity, null) != null ? [{
      type = var.linux_function.identity.type
      identity_ids = var.linux_function.identity.identity_ids
    }] : []
    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }

  dynamic "storage_account" {
    for_each = try(var.linux_function.storage_account, {})
    content {
      access_key   = storage_account.value.access_key
      account_name = storage_account.value.account_name
      name         = storage_account.value.name
      share_name   = storage_account.value.share_name
      type         = storage_account.value.type
      mount_path   = try(storage_account.value.mount_path, null)
    }
  }

  dynamic "sticky_settings" {
    for_each = try(var.linux_function.sticky_settings, {})
    content {
      app_setting_names       = try(sticky_settings.value.app_setting_names, null)
      connection_string_names = try(sticky_settings.value.connection_string_names, null)
    }
  }
}

# Calls this module if we need a private endpoint attached to the storage account
module "private_endpoint" {
  source = "github.com/canada-ca-terraform-modules/terraform-azurerm-caf-private_endpoint.git?ref=v1.0.2"
  for_each =  try(var.linux_function.private_endpoint, {}) 

  name = "${local.func-name}-${each.key}"
  location = var.location
  resource_groups = var.resource_groups
  subnets = var.subnets
  private_connection_resource_id = azurerm_linux_function_app.linux-function.id
  private_endpoint = each.value
  private_dns_zone_ids = var.private_dns_zone_ids
  tags = var.tags
}

locals {
  cert_url = strcontains(var.env, "G3") ? "https://g3pceslzresentdfa0353e.blob.core.windows.net/publicresources/GOC-GDC-ROOT-A.crt" : "https://gcpcenteslzpublicblob4df.blob.core.windows.net/publicresources/GOC-GDC-ROOT-A.crt" 
}

data "http" "cert" {
  for_each = { for url in [local.cert_url]: "GOC-GDC-ROOT-A" => url if try(var.linux_function.inject_root_cert, false) }
  url = each.value
}

resource "azurerm_app_service_public_certificate" "internal-ca" {
  for_each = data.http.cert

  app_service_name     = azurerm_linux_function_app.linux-function.name
  resource_group_name  = azurerm_linux_function_app.linux-function.resource_group_name
  certificate_name     = each.key
  certificate_location = "Unknown"
  blob                 = each.value.response_body_base64
}