#
# CORE KEYVAULT
#

module "secret_core" {
  source = "github.com/pagopa/terraform-azurerm-v3//key_vault_secrets_query?ref=v8.9.0"
  providers = {
    azurerm = azurerm.prod
  }

  resource_group = local.prod_key_vault_azdo_resource_group
  key_vault_name = local.prod_key_vault_azdo_name

  secrets = [
    "azure-devops-github-ro-TOKEN",
  ]
}
