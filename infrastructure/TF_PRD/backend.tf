terraform {
  backend "remote" {
  }
}

# terraform {
#   backend "remote" {
#     hostname     = "app.terraform.io"
#     organization = "firstorg21"

#     workspaces {
#       name = "terraform"
#     }
#   }
# }



provider "azurerm" {
  features {}
}

#This is check 1.1.1.1.1.1
