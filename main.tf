provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

resource "azurerm_resource_group" "dev" {
  name     = var.rg_name
  location = var.location
}

resource "azurerm_app_service_plan" "dev" {
  name                = var.appservice_plan
  location            = azurerm_resource_group.dev.location
  resource_group_name = azurerm_resource_group.dev.name
  sku {
    tier = "Free"
    size = "F1"
  }
}
resource "azurerm_app_service" "dev" {
  name                = var.appservice_name
  location            = azurerm_resource_group.dev.location
  resource_group_name = azurerm_resource_group.dev.name
  app_service_plan_id = azurerm_app_service_plan.dev.id
}


resource "null_resource" "ftp_fileupload" {

  depends_on = [azurerm_app_service.dev]
  triggers = {
    always_run = timestamp()
  }
  provisioner "local-exec" {
    command = data.template_file.init.rendered
  }
}

data "template_file" "init" {
  template = file("${path.module}/appdeploy.sh")

  vars = {
    app_service_name = azurerm_app_service.dev.name
    app_rg_name      = azurerm_resource_group.dev.name
    client_id        = var.client_id
    client_secret    = var.client_secret
    tenant_id        = var.tenant_id
  }
}
