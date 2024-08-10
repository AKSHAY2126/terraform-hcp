terraform {
  backend "remote" {
    # resource_group_name  = "myrg-1"
    # storage_account_name = "mytfstateaccount2121"
    # container_name       = "tfstate"
    # key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
  # tenant_id       = "a49be146-23d3-44fa-951f-f7210572c2ad"
  # client_id       = "24d083e5-cf7f-47c9-b923-17446ecc095b"
  # client_secret   = "0348Q~u76uOt66HUctvA2_hbR8VteOZc3hPd4aKq"
  # subscription_id = "71aaef51-8d4b-4b1d-9e60-7208f4010806"
}