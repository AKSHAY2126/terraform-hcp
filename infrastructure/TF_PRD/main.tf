terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.115.0"
    }
  }
}

provider "azurerm" {
  features {}
}



# resource "azurerm_resource_group" "example" {
#   name     = "example"
#   location = "West Europe"
# }


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
    "WEBSITE_CONTENTSHARE"                = azurerm_storage_share.example.name
    "AZURE_STORAGE_ACCOUNT_NAME"          = azurerm_storage_account.example.name
    "AZURE_STORAGE_ACCOUNT_ACCESS_KEY"    = azurerm_storage_account.example.primary_access_key
  }

  site_config {
    linux_fx_version = "PYTHON|3.8"  # Example runtime stack
  }
}
