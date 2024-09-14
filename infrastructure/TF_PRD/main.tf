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



resource "azurerm_resource_group" "example" {
  name     = "example"
  location = "West Europe"
}

#This is check code 1.1.1.1.1.1.1.1.
