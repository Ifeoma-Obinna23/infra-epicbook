terraform {
  backend "azurerm" {
    resource_group_name  = "rg-epicbook-tfstate"
    storage_account_name = "tfstateifeoma30524"
    container_name       = "tfstate"
    key                  = "epicbook.tfstate"
  }
}