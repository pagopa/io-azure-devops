module "secrets" {
  source = "github.com/pagopa/terraform-azurerm-v3//key_vault_secrets_query?ref=v8.7.0"

  resource_group = "io-p-rg-operations"
  key_vault_name = "io-p-kv-azuredevops"

  secrets = [
    "DANGER-GITHUB-API-TOKEN",
    "io-azure-devops-github-ro-TOKEN",
    "io-azure-devops-github-rw-TOKEN",
    "io-azure-devops-github-pr-TOKEN",
    "io-azure-devops-github-EMAIL",
    "io-azure-devops-github-USERNAME",
    "PAGOPAIT-PROD-IO-SUBSCRIPTION-ID",
    "PAGOPAIT-DEV-IO-SUBSCRIPTION-ID",
    "PAGOPAIT-TENANTID",
    "pagopa-npm-bot-TOKEN",
  ]
}
