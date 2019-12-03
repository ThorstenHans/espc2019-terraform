locals {
  default_tags = {
    tool = "Terraform"
  }

  all_tags = merge(local.default_tags, var.custom_tags)

}

resource "azurerm_resource_group" "espcrg" {
  name     = "espc-${var.environment_name}"
  location = var.location
  tags     = local.all_tags
}
resource "azurerm_app_service_plan" "espcasp" {
  name                = "asp-espc-${var.environment_name}"
  resource_group_name = azurerm_resource_group.espcrg.name
  location            = var.location
  kind                = "Linux"
  reserved            = true
  sku {
    tier = "Standard"
    size = var.asp_size
  }
  tags = local.all_tags
}

resource "azurerm_app_service" "espcas" {
  name                = "as-espc-${var.environment_name}"
  resource_group_name = azurerm_resource_group.espcrg.name
  location            = var.location
  app_service_plan_id = azurerm_app_service_plan.espcasp.id
  tags                = local.all_tags
  site_config {
    always_on        = false
    linux_fx_version = "DOCKER|nginx:latest"
  }
  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_application_insights" "espcai" {
  name                = "ai-espc-${var.environment_name}"
  tags                = local.all_tags
  resource_group_name = azurerm_resource_group.espcrg.name
  location            = var.location
  application_type    = "web"
  count               = var.deploy_ai ? 1 : 0
}

