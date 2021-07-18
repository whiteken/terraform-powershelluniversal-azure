resource "azurerm_resource_group" "rg" {
  name     = "devtest-${var.project_name}-${var.azure_region_short}-rg1"
  location = var.azure_region
}

resource "azurerm_app_service_plan" "myplan" {
  name                = var.project_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  kind                = "Windows"
  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_app_service" "main" {
  name                = var.project_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.myplan.id

  site_config {
    dotnet_framework_version  = "v4.0"
    managed_pipeline_mode = "Integrated"
    websockets_enabled        = true
    ftps_state                = "AllAllowed"
    use_32_bit_worker_process = false
  }
}