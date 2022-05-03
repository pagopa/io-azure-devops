module "secrets" {
  source = "git::https://github.com/pagopa/azurerm.git//key_vault_secrets_query?ref=v2.0.5"

  resource_group = local.prod_key_vault_resource_group
  key_vault_name = local.prod_key_vault_name

  secrets = [
    "azure-devops-github-ro-TOKEN",
    "azure-devops-github-pr-TOKEN",
    "azure-devops-github-EMAIL",
    "azure-devops-github-USERNAME",
    "TENANTID",
    "DEV-SUBSCRIPTION",
    "UAT-SUBSCRIPTION",
    "PROD-SUBSCRIPTION",
  ]
}

# module "secrets_prod" {
#   source = "git::https://github.com/pagopa/azurerm.git//key_vault_secrets_query?ref=v2.0.5"
#   providers = {
#     azurerm = azurerm.prod
#   }

#   resource_group = local.prod_key_vault_resource_group
#   key_vault_name = local.prod_key_vault_name

#   secrets = [
#     "aks-apiserver-url",
#     "aks-azure-devops-sa-cacrt",
#     "aks-azure-devops-sa-token",
#   ]
# }

# module "secrets_dev" {
#   source = "git::https://github.com/pagopa/azurerm.git//key_vault_secrets_query?ref=v2.0.5"
#   providers = {
#     azurerm = azurerm.dev
#   }

#   resource_group = local.dev_key_vault_resource_group
#   key_vault_name = local.dev_key_vault_name

#   secrets = [
#     "aks-apiserver-url",
#     "aks-azure-devops-sa-cacrt",
#     "aks-azure-devops-sa-token",
#   ]
# }

# module "secrets_uat" {
#   source = "git::https://github.com/pagopa/azurerm.git//key_vault_secrets_query?ref=v2.0.5"
#   providers = {
#     azurerm = azurerm.uat
#   }

#   resource_group = local.uat_key_vault_resource_group
#   key_vault_name = local.uat_key_vault_name

#   secrets = [
#     "aks-apiserver-url",
#     "aks-azure-devops-sa-cacrt",
#     "aks-azure-devops-sa-token",
#   ]
# }
