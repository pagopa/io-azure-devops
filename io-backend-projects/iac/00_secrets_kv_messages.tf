#
# PROD ECOMMERCE KEYVAULT
#

module "messages_prod_secrets" {
  source = "github.com/pagopa/terraform-azurerm-v3//key_vault_secrets_query?ref=v8.9.0"

  resource_group = local.prod_messages_key_vault_resource_group
  key_vault_name = local.prod_messages_key_vault_name

  secrets = [
    "io-p-weu-beta-aks-apiserver-url",
    "io-p-weu-beta-aks-azure-devops-sa-cacrt",
    "io-p-weu-beta-aks-azure-devops-sa-token",
    "io-p-weu-prod01-aks-apiserver-url",
    "io-p-weu-prod01-aks-azure-devops-sa-cacrt",
    "io-p-weu-prod01-aks-azure-devops-sa-token",
  ]
}
