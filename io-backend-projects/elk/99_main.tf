terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = "<= 0.10.0"
    }
    azurerm = {
      version = "<= 3.100.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = ">= 2.30.0"
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 3.2.1"
    }
    time = {
      source  = "hashicorp/time"
      version = ">= 0.7.0"
    }
  }
  backend "azurerm" {}
}

data "azurerm_client_config" "current" {}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = false
    }
  }
}

# Prod

data "azurerm_subscriptions" "prod" {
  display_name_prefix = local.prod_subscription_name
}

provider "azurerm" {
  alias = "prod"
  features {
    key_vault {
      purge_soft_delete_on_destroy = false
    }
  }
  subscription_id = data.azurerm_subscriptions.prod.subscriptions[0].subscription_id
}

