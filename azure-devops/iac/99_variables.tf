variable "iac-project-name" {
  type        = string
  description = "Name of the project on AZDO"
}

variable "aks_platform_beta_prod_name" {
  type        = string
  description = "Name of the aks plarfom BETA"
}

variable "aks_platform_prod01_prod_name" {
  type        = string
  description = "Name of the aks plarfom PROD01"
}

locals {
  project_prefix_short = "io"
  azure_devops_org     = "pagopaspa"
  github_org           = "pagopa"
  prefix               = "io"


  # 🔐 KV AZDO
  prod_key_vault_resource_group = "io-p-rg-operations"
  prod_key_vault_azdo_name      = "io-p-kv-azuredevops"

  # 🔐 KV Domain
  dev_messages_key_vault_resource_group  = "${local.prefix}-d-messages-sec-rg"
  uat_messages_key_vault_resource_group  = "${local.prefix}-u-messages-sec-rg"
  prod_messages_key_vault_resource_group = "${local.prefix}-p-messages-sec-rg"

  dev_messages_key_vault_name  = "${local.prefix}-d-messages-kv"
  uat_messages_key_vault_name  = "${local.prefix}-u-messages-kv"
  prod_messages_key_vault_name = "${local.prefix}-p-messages-kv"

}
