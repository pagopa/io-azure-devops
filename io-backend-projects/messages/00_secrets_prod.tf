module "secrets_azdo" {
  source = "github.com/pagopa/terraform-azurerm-v3//key_vault_secrets_query?ref=v8.9.0"

  resource_group = local.prod_key_vault_azdo_resource_group
  key_vault_name = local.prod_key_vault_azdo_name

  secrets = [
    "azure-devops-github-ro-TOKEN",
    "azure-devops-github-pr-TOKEN",
    "azure-devops-github-rw-TOKEN",
    "azure-devops-github-EMAIL",
    "azure-devops-github-USERNAME",
    "DANGER-GITHUB-API-TOKEN",
  ]
}

module "secrets_prod" {
  source = "github.com/pagopa/terraform-azurerm-v3//key_vault_secrets_query?ref=v8.9.0"

  resource_group = local.prod_key_vault_resource_group
  key_vault_name = local.prod_key_vault_name

  secrets = [
    "${local.prefix}-p-weu-beta-aks-apiserver-url",
    "${local.prefix}-p-weu-beta-aks-azure-devops-sa-cacrt",
    "${local.prefix}-p-weu-beta-aks-azure-devops-sa-token",
    "${local.prefix}-p-weu-prod01-aks-apiserver-url",
    "${local.prefix}-p-weu-prod01-aks-azure-devops-sa-cacrt",
    "${local.prefix}-p-weu-prod01-aks-azure-devops-sa-token",
  ]
}
