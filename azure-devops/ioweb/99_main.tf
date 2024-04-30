terraform {
  required_version = ">= 1.1.5"
  required_providers {
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = "<= 0.10.0"
    }
    azurerm = {
      version = "<= 3.100.0"
    }
  }
  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {}

data "azurerm_subscription" "current" {}
