provider "azurerm" {
  features {}
}

# Create Resource Group
resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "East US"
}

# Create Storage Account
resource "azurerm_storage_account" "example" {
  name                     = "examplestoracc"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Create File Share in Storage Account
resource "azurerm_storage_share" "example" {
  name                 = "exampleshare"
  storage_account_name = azurerm_storage_account.example.name
  quota                = 50
}

# Create App Service Plan
resource "azurerm_app_service_plan" "example" {
  name                = "example-appserviceplan"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku {
    tier = "Standard"
    size = "S1"
  }
}

# Create Web App
resource "azurerm_linux_web_app" "example" {
  name                = "example-webapp"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  service_plan_id     = azurerm_app_service_plan.example.id

  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "true"
  }

  site_config {
    linux_fx_version = "PYTHON|3.8"  # Example runtime stack (adjust as needed)
  }

  storage_account {
    name      = azurerm_storage_account.example.name
    access_key = azurerm_storage_account.example.primary_access_key
    mount_path = "/mnt/storage"
    share_name = azurerm_storage_share.example.name
  }
}
