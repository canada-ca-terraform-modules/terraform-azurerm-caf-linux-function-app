linux-functions = {
  test = {
    resource_group = "Project"
    asp            = "asp"

    # app_settings                                   = {}
    # builtin_logging_enabled                        = true
    # client_certificate_enabled                     = false
    # client_certificate_mode                        = "Optional"
    # client_certificate_exclusion_paths             = ""
    # daily_memory_time_quota                        = 0
    # enabled                                        = true
    # content_share_force_disabled                   = false
    # functions_extension_version                    = "~4"
    # ftp_publish_basic_authentication_enabled       = false
    # https_only                                     = true
    # inject_root_cert                               = false
    # public_network_access_enabled                  = true
    # key_vault_reference_identity_id                = ""
    # storage_account_access_key                     = ""
    # storage_account_name                           = ""     # This setting is mandatory if a custom storage account is not created
    # storage_uses_managed_identity                  = ""
    # storage_key_vault_secret_id                    = ""
    # virtual_network_subnet_id                      = ""
    # webdeploy_publish_basic_authentication_enabled = true
    # vnet_image_pull_enabled                        = true
    # zip_deploy_file                                = ""

    site_config = {
      always_on = true
      # api_definition_url                            = ""
      # api_management_api_id                         = ""
      # app_command_line                              = ""
      # app_scale_limit                               = 2
      # application_insights_connection_string        = ""
      # application_insights_key                      = ""
      # container_registry_managed_identity_client_id = ""
      # container_registry_use_managed_identity       = ""
      # default_documents                             = ""
      # elastic_instance_minimum                      = 2
      # ftps_state                                    = "Disabled"
      # health_check_path                             = ""
      # health_check_eviction_time_in_min             = ""
      # http2_enabled                                 = false
      # ip_restriction_default_action                 = "Allow"
      # load_balancing_mode                           = "LeastRequests"
      # managed_pipeline_mode                         = "Integrated"
      # minimum_tls_version                           = "1.2"
      # pre_warmed_instance_count                     = 2
      # remote_debugging_enabled                      = false
      # remote_debugging_version                      = "VS2022"
      # runtime_scale_monitoring_enabled              = false
      # scm_ip_restriction_default_action             = "Allow"
      # scm_minimum_tls_version                       = "1.2"
      # scm_use_main_ip_restriction                   = false
      # use_32_bit_worker                             = false
      # vnet_route_all_enabled                        = false
      # websockets_enabled                            = false
      # worker_count                                  = "2"

      # application_stack = {
      #   # docker = {
      #   #   registry_url      = ""
      #   #   image_name        = ""
      #   #   image_tag         = ""
      #   #   registry_username = ""
      #   #   registry_password = ""
      #   # }
      #   dotnet_version              = "9.0"
      #   use_dotnet_isolated_runtime = "false"
      #   java_version                = "17"
      #   node_version                = "20"
      #   python_version              = "3.12"
      #   powershell_core_version     = "7.4"
      #   use_custom_runtime          = false
      # }

      #   app_service_logs = {
      #     disk_quota_mb         = 35
      #     retention_period_days = 90
      #   }

      #   cors = {
      #     allowed_origins     = ""
      #     support_credentials = false
      #   }

      #   ip_restriction = {
      #     action                    = "Deny"
      #     ip_address                = ""
      #     name                      = ""
      #     priority                  = ""
      #     service_tag               = ""
      #     virtual_network_subnet_id = ""
      #     description               = ""
      #     headers = {
      #       x_azure_fdid      = ""
      #       x_fd_health_probe = ""
      #       x_forwarded_for   = ""
      #       x_forwarded_host  = ""
      #     }
      #   }

      #   scm_ip_restriction = {
      #     action                    = "Deny"
      #     ip_address                = ""
      #     name                      = ""
      #     priority                  = ""
      #     service_tag               = ""
      #     virtual_network_subnet_id = ""
      #     description               = ""
      #     headers = {
      #       x_azure_fdid      = ""
      #       x_fd_health_probe = ""
      #       x_forwarded_for   = ""
      #       x_forwarded_host  = ""
      #     }
      #   }
      # }
    }

    custom_storage_account = {
      resource_group = "Project"
      subnet = "OZ"
    }

    # auth_settings = {
    #   enabled                        = false
    #   additional_login_parameters    = ""
    #   allowed_external_redirect_urls = ""
    #   default_provider               = ""
    #   issuer                         = ""
    #   runtime_version                = ""
    #   token_refresh_extension_hours  = 72
    #   token_store_enabled            = false
    #   unauthenticated_client_action  = ""

    #   active_directory = {
    #     client_id                  = ""
    #     allowed_audiences          = ""
    #     client_secret              = ""
    #     client_secret_setting_name = ""
    #   }
    #   facebook = {
    #     app_id                  = ""
    #     app_secret              = ""
    #     app_secret_setting_name = ""
    #     oauth_scopes            = ""
    #   }

    #   github = {
    #     client_id                  = ""
    #     client_secret              = ""
    #     client_secret_setting_name = ""
    #     oauth_scopes               = ""
    #   }

    #   google = {
    #     client_id                  = ""
    #     client_secret              = ""
    #     client_secret_setting_name = ""
    #     oauth_scopes               = ""
    #   }

    #   microsoft = {
    #     client_id                  = ""
    #     client_secret              = ""
    #     client_secret_setting_name = ""
    #     oauth_scopes               = ""
    #   }

    #   twitter = {
    #     consumer_key                 = ""
    #     consumer_secret              = ""
    #     consumer_secret_setting_name = ""
    #   }
    # }

    # auth_settings_v2 = {
    #   auth_enabled                            = false
    #   runtime_version                         = "~1"
    #   config_file_path                        = ""
    #   require_authentication                  = ""
    #   unauthenticated_action                  = ""
    #   default_provider                        = ""
    #   excluded_paths                          = ""
    #   require_https                           = true
    #   http_route_api_prefix                   = ""
    #   forward_proxy_convention                = "NoProxy"
    #   forward_proxy_custom_host_header_name   = ""
    #   forward_proxy_custom_scheme_header_name = ""

    #   login = {
    #     logout_endpoint                   = ""
    #     token_store_enabled               = false
    #     token_refresh_extension_time      = 72
    #     token_store_path                  = ""
    #     token_store_sas_setting_name      = ""
    #     preserve_url_fragments_for_logins = false
    #     allowed_external_redirect_urls    = ""
    #     cookie_expiration_convention      = ""
    #     cookie_expiration_time            = "08:00:00"
    #     validate_nonce                    = true
    #     nonce_expiration_time             = "00:05:00"
    #   }

    #   active_directory_v2 = {
    #     client_id                            = ""
    #     tenant_auth_endpoint                 = ""
    #     client_secret_setting_name           = ""
    #     client_secret_certificate_thumbprint = ""
    #     jwt_allowed_groups                   = ""
    #     jwt_allowed_client_applications      = ""
    #     www_authentication_disabled          = false
    #     allowed_groups                       = ""
    #     allowed_identities                   = ""
    #     allowed_applications                 = ""
    #     allowed_audiences                    = ""
    #     login_parameters                     = ""
    #   }

    #   azure_static_web_app_v2 = {
    #     client_id = ""
    #   }

    #   custom_oidc_v2 = {
    #     name                          = ""
    #     client_id                     = ""
    #     openid_configuration_endpoint = ""
    #     name_claim_type               = ""
    #     scopes                        = ""
    #     client_credential_method      = ""
    #     client_secret_setting_name    = ""
    #     authorisation_endpoint        = ""
    #     token_endpoint                = ""
    #     issuer_endpoint               = ""
    #     certification_url             = ""
    #   }

    #   facebook_v2 = {
    #     app_id                  = ""
    #     app_secret_setting_name = ""
    #     graph_api_version       = ""
    #     login_scopes            = ""
    #   }

    #   github_v2 = {
    #     client_id                  = ""
    #     client_secret_setting_name = ""
    #     login_scopes               = ""
    #   }

    #   google_v2 = {
    #     client_id                  = ""
    #     client_secret_setting_name = ""
    #     allowed_audiences          = ""
    #     login_scopes               = ""
    #   }

    #   microsoft_v2 = {
    #     client_id                  = ""
    #     client_secret_setting_name = ""
    #     allowed_audiences          = ""
    #     login_scopes               = ""
    #   }

    #   twitter_v2 = {
    #     consumer_key                 = ""
    #     consumer_secret_setting_name = ""
    #   }
    # }

    #   backup = {
    #     name                = ""
    #     storage_account_url = ""
    #     enabled             = true

    #     schedule = {
    #       frequency_interval       = ""
    #       frequency_unit           = ""
    #       keep_at_least_one_backup = false
    #       retention_period_days    = 30
    #       start_time               = ""
    #     }
    #   }

    #   connection_string = {
    #     name  = ""
    #     type  = ""
    #     value = ""
    #   }

    #   identity = {
    #     type         = ""
    #     identity_ids = ""
    #   }

    #   storage_account = {
    #     access_key   = ""
    #     account_name = ""
    #     name         = ""
    #     share_name   = ""
    #     type         = ""
    #     mount_path   = ""
    #   }

    #   sticky_settings = {
    #     app_setting_names       = ""
    #     connection_string_names = ""
    #   }
    # }
    tags = {}

    private_endpoint = {
      test = {                           # Key defines the userDefinedstring
        resource_group       = "Project" # Required: Resource group name, i.e Project, Management, DNS, etc, or the resource group ID
        subnet               = "OZ"      # Required: Subnet name, i.e OZ,MAZ, etc, or the subnet ID
        subresource_names    = ["sites"] # Required: Even if it's a list, only one resource is allowed for most first party Azure resource. It's a terraform requirement. See: https://learn.microsoft.com/en-us/azure/private-link/private-endpoint-overview#private-link-resource for list of subresrouce
        is_manual_connection = false     # Optional: Possible values: true, false. Default: true
        # local_dns_zone       = "privatelink.blob.core.windows.net"    # Optional: Name of the local DNS zone for the private endpoint. To change this value, you must taint the associated resource
      }
    } 
  }
}

