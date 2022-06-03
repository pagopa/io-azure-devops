# variable "dev_subscription_name" {
#   type        = string
#   description = "DEV Subscription name"
# }

# variable "uat_subscription_name" {
#   type        = string
#   description = "UAT Subscription name"
# }

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
  domain           = "messages"

  # 🔐 KV
  # dev_key_vault_azdo_name  = "${local.prefix}-d-azdo-weu-kv"
  # uat_key_vault_azdo_name  = "${local.prefix}-u-azdo-weu-kv"
  prod_key_vault_azdo_name = "${local.prefix}-p-azdo-weu-kv"

  # dev_key_vault_azdo_resource_group  = "${local.prefix}-d-sec-rg"
  # uat_key_vault_azdo_resource_group  = "${local.prefix}-u-sec-rg"
  prod_key_vault_azdo_resource_group = "${local.prefix}-p-sec-rg"

  # dev_key_vault_name  = "${local.prefix}-d-${local.domain}-kv"
  # uat_key_vault_name  = "${local.prefix}-u-${local.domain}-kv"
  prod_key_vault_name = "${local.prefix}-p-${local.domain}-kv"

  # dev_key_vault_resource_group  = "${local.prefix}-d-${local.domain}-sec-rg"
  # uat_key_vault_resource_group  = "${local.prefix}-u-${local.domain}-sec-rg"
  prod_key_vault_resource_group = "${local.prefix}-p-${local.domain}-sec-rg"

  # ☁️ VNET
  # dev_dns_zone_resource_group  = "${local.prefix}-d-vnet-rg"
  # uat_dns_zone_resource_group  = "${local.prefix}-u-vnet-rg"
  prod_dns_zone_resource_group = "${local.prefix}-p-rg-external"

  # 📦 ACR PROD DOCKER
  srv_endpoint_name_docker_registry_prod = "${local.prefix}-p-${local.domain}-acr-docker-registry-prod"
  docker_registry_rg_name_prod           = "${local.prefix}-p-container-registry-rg"
  docker_registry_name_prod              = "${local.prefix}pcommonacr"

  srv_endpoint_name_aks_weu_beta_prod   = "${local.prefix}-${local.domain}-aks-weu-beta"
  srv_endpoint_name_aks_weu_prod01_prod = "${local.prefix}-${local.domain}-aks-weu-prod01"
  srv_endpoint_name_aks_weu_prod02_prod = "${local.prefix}-${local.domain}-aks-weu-prod02"

  #tfsec:ignore:general-secrets-no-plaintext-exposure
  #tfsec:ignore:GEN002
  tlscert_renew_token = "v1"
}