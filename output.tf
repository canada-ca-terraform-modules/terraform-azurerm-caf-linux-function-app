output "linux_function_app_object" {
  description = "Outputs the entire function app object"
  value = azurerm_linux_function_app.linux-function
}

output "linux_function_app_name" {
  description = "Outputs the function app name"
  value = azurerm_linux_function_app.linux-function.name
}

output "linux_function_app_id" {
  description = "Outputs the function app id"
  value = azurerm_linux_function_app.linux-function.id
}

output "linux_function_umi" {
  description = "The User Managed Identity that was created for this function"
  value = try(module.linux-function-umi[0], null)
}