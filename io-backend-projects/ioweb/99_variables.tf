variable "prod_subscription_name" {
  type        = string
  description = "PROD Subscription name"
}

variable "project_name_prefix" {
  type        = string
  description = "Project name prefix (e.g. userregistry)"
}

locals {
  prefix           = "io"
  azure_devops_org = "pagopaspa"
  domain           = "ioweb"
  location         = "westeurope"
  location_short   = "itn"

  # 🔐 KV
  # dev_key_vault_azdo_name  = "${local.prefix}-d-azdo-weu-kv"
  # uat_key_vault_azdo_name  = "${local.prefix}-u-azdo-weu-kv"
  prod_key_vault_azdo_name = "${local.prefix}-p-azdo-weu-kv"

  # dev_key_vault_azdo_resource_group  = "${local.prefix}-d-sec-rg"
  # uat_key_vault_azdo_resource_group  = "${local.prefix}-u-sec-rg"
  prod_key_vault_azdo_resource_group = "${local.prefix}-p-sec-rg"

  # dev_key_vault_name  = "${local.prefix}-d-${local.domain}-kv"
  # uat_key_vault_name  = "${local.prefix}-u-${local.domain}-kv"
  prod_key_vault_name           = "${local.prefix}-p-${local.location_short}-${local.domain}-kv-01"
  prod_key_vault_resource_group = "${local.prefix}-p-${local.location_short}-auth-main-rg-01"

  # dev_key_vault_resource_group  = "${local.prefix}-d-${local.domain}-sec-rg"
  # uat_key_vault_resource_group  = "${local.prefix}-u-${local.domain}-sec-rg"

  # ☁️ VNET
  # dev_dns_zone_resource_group  = "${local.prefix}-d-vnet-rg"
  # uat_dns_zone_resource_group  = "${local.prefix}-u-vnet-rg"
  prod_dns_zone_resource_group = "${local.prefix}-p-rg-external"

  #tfsec:ignore:general-secrets-no-plaintext-exposure
  #tfsec:ignore:GEN002
  tlscert_renew_token = "v2"

  agent_pool = "${local.prefix}-prod-linux"

  identity_rg_name = "${local.prefix}-p-identity-rg"
}
