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
  default = "1d11b6a5-9652-4589-a208-89bcac57ba39"
}
variable "client_id" {
  description = "Azure SPN Client ID"
  type = string
  default = "5c22e7e8-e019-434f-8974-84d45a2f5e97"
}
variable "client_secret" {
  description = "Azure SPN Client Secret"
  type = string
  default = "CJAb57Ua20iggDZyD1ewMBP3.b4d-.-20u"
}
variable "tenant_id" {
  description = "Azure Tenant ID"
  type = string
  default = "723aa938-17e0-4144-b82c-2903de9e1337"
}