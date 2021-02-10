

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

resource "azurerm_resource_group" "dev" {
  name     = "appservice-ftp-rg1"
  location = "westeurope"
}

resource "azurerm_app_service_plan" "dev" {
  name                = "appservice-ftp-plan1"
  location            = azurerm_resource_group.dev.location
  resource_group_name = azurerm_resource_group.dev.name
  sku {
    tier = "Free"
    size = "F1"
  }
}
resource "azurerm_app_service" "dev" {
  name                = "appservice-ftp1"
  location            = azurerm_resource_group.dev.location
  resource_group_name = azurerm_resource_group.dev.name
  app_service_plan_id = azurerm_app_service_plan.dev.id
}


locals {
  hosts_file_content = <<EOT
  appservice-ftp1\$appservice-ftp1:6le2J4m41cfp2akDgbKewQmvqNL6kcatENiMa5i42coWjstTfpihmpWhoniB ftp://waws-prod-am2-257.ftp.azurewebsites.windows.net/site/wwwroot/
  EOT
}


#output "stdout" {
#value = "${null_resource.health_check2.local-exec.output}"
#}

resource "null_resource" "health_check2" {

  depends_on = [azurerm_app_service.dev]
  triggers = {
    always_run = "${timestamp()}"
  }

  #provisioner "local-exec" {

  #command     = <<-EOT
  #ftpPublishingUrl=$(az webapp show -n ${azurerm_app_service.dev.name} -g ${azurerm_resource_group.dev.name} --query ftpPublishingUrl)
  #echo $ftpPublishingUrl
  #EOT
  #interpreter = ["/bin/bash", "-c"]
  #}
  #provisioner "local-exec" {
  #command = "${data.template_file.init.rendered}"
  #}

  provisioner "local-exec" {
    command = "ftpname=$(az webapp deployment list-publishing-credentials -n appservice-ftp1 -g appservice-ftp-rg1 --query name) ;publishingUserName=$(az webapp deployment list-publishing-credentials -n appservice-ftp1 -g appservice-ftp-rg1 --query publishingUserName) ; echo $publishingUserName"
  }
  #provisioner "local-exec" {
  #command = "cat > test_output.sh <<EOL\n${data.template_file.init.rendered}\nEOL"
  #}

  #provisioner "local-exec" {
  #command = "curl -T data.jar -u ${local.hosts_file_content}"
  #}

  #provisioner "local-exec" {
  #command = "${data.template_file.init.rendered}"
  #}
  #provisioner "local-exec" {
  #command = "az webapp show -n ${azurerm_app_service.dev.name} -g ${azurerm_resource_group.dev.name} --query ftpPublishingUrl "
  #}
  #provisioner "local-exec" {
  #command = "\: /site/wwwroot/"
  #}

}

data "template_file" "init" {
  template = "${file("${path.module}/appdeploy1.sh")}"

  vars = {
    app_service_name = "${azurerm_app_service.dev.name}"
    app_rg_name      = "${azurerm_resource_group.dev.name}"
    client_id        = var.client_id
    client_secret    = var.client_secret
    tenant_id        = var.tenant_id
    ftpPublishingUrl = "{var.ftpPublishingUrl}"
  }
}
