#
# PROD ECOMMERCE KEYVAULT
#

module "profile_prod_secrets" {

  providers = {
    azurerm = azurerm.prod
  }

  source = "git::https://github.com/pagopa/azurerm.git//key_vault_secrets_query?ref=v2.18.9"

  resource_group = local.prod_profile_key_vault_resource_group
  key_vault_name = local.prod_profile_key_vault_name

  secrets = [
    "io-p-weu-beta-aks-apiserver-url",
    "io-p-weu-beta-aks-azure-devops-sa-cacrt",
    "io-p-weu-beta-aks-azure-devops-sa-token",
    "io-p-weu-prod01-aks-apiserver-url",
    "io-p-weu-prod01-aks-azure-devops-sa-cacrt",
    "io-p-weu-prod01-aks-azure-devops-sa-token",
  ]
}
