variable "tags" {
  description = "Tags to be applied to the function app"
  type = map(string)
  default = {}
}

variable "userDefinedString" {
  description = "(Required) UserDefinedString part of the name of the function app"
  type = string
}

variable "env" {
  description = "(Required) Env part of the name of the function app"
  type = string
}

variable "group" {
  description = "(Required) Group part of the name of the function app"
  type = string
}

variable "project" {
  description = "(Required) Project part of the name of the function app"
  type = string
}

variable "resource_groups" {
  description = "(Required) List of resource groups in the target project"
  type = any
  default = null
}

variable "location" {
  description = "Azure location where the function will be located"
  type = string
  default = "canadacentral"
}

variable "linux_function" {
  description = "Object description all the function parameters"
  type = any
  default = {}
}

variable "asp" {
  description = "Object containing a map of name and ID for the App Service Plan in the target subscription"
  type = any
  default = null
}

variable "subnets" {
  description = "Object containing subnet objects of the target project"
  type = any
  default = {}
}

variable "private_dns_zone_ids" {
  description = "Object containing the private DNS zone IDs of the subscription. Used to configure private endpoints"
  type = any
  default = {}
}
