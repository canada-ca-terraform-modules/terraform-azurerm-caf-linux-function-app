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