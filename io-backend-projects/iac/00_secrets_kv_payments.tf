#
# PROD ECOMMERCE KEYVAULT
#

module "payments_prod_secrets" {
  source = "github.com/pagopa/terraform-azurerm-v3//key_vault_secrets_query?ref=v8.9.0"

  resource_group = local.prod_payments_key_vault_resource_group
  key_vault_name = local.prod_payments_key_vault_name

  secrets = [
    "io-p-weu-prod01-aks-apiserver-url",
    "io-p-weu-prod01-aks-azure-devops-sa-cacrt",
    "io-p-weu-prod01-aks-azure-devops-sa-token",
  ]
}
