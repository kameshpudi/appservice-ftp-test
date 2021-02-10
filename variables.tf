variable "location" {
  description = "Location"
  type = string
  default = "westeurope"
}
variable "rg_name" {
  description = "Azure ResourceGroup name"
  type = string
  default = "appservice-ftptest-rg"
}
variable "appservice_plan" {
  description = "App Service Plan"
  type = string
  default = "appservice-ftp-plan12"
}
variable "appservice_name" {
  description = "App Service Name"
  type = string
  default = "appservice-ftp12"
}

variable "subscription_id" {
  description = "Azure Subscription ID"
  type = string
  default = "XXXX"
}
variable "client_id" {
  description = "Azure SPN Client ID"
  type = string
  default = "XXXX"
}
variable "client_secret" {
  description = "Azure SPN Client Secret"
  type = string
  default = "XXXX"
}
variable "tenant_id" {
  description = "Azure Tenant ID"
  type = string
  default = "XXXX"
}