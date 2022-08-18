module "secret_azdo" {
  source = "git::https://github.com/pagopa/azurerm.git//key_vault_secrets_query?ref=v2.4.0"

  resource_group = local.prod_key_vault_resource_group
  key_vault_name = local.prod_key_vault_azdo_name

  secrets = [
    "io-azure-devops-github-ro-TOKEN",
    "io-azure-devops-github-pr-TOKEN",
    "PAGOPAIT-TENANTID",
    "PAGOPAIT-PROD-IO-SUBSCRIPTION-ID",
  ]
}
