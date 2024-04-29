terraform {
  required_version = ">= 1.1.5"
  required_providers {
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = "<= 0.11.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "<= 3.100.0"
    }
  }
  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = false
    }
  }
  alias           = "prod"
  subscription_id = module.secrets_azdo.values["PROD-SUBSCRIPTION-ID"].value
}
