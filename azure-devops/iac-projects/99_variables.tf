variable "dev_subscription_name" {
  type        = string
  description = "DEV Subscription name"
}

variable "uat_subscription_name" {
  type        = string
  description = "UAT Subscription name"
}

variable "prod_subscription_name" {
  type        = string
  description = "PROD Subscription name"
}

variable "project_iac_name" {
  type        = string
  description = "Project name for IaC projects"
}

variable "aks_dev_platform_name" {
  type        = string
  description = "AKS DEV platform name"
}

variable "aks_uat_platform_name" {
  type        = string
  description = "AKS UAT platform name"
}

variable "aks_prod_platform_name" {
  type        = string
  description = "AKS PROD platform name"
}

locals {
  project_prefix_short = "io"
  azure_devops_org     = "pagopaspa"
  github_org           = "pagopa"
  prefix               = "io"


  # 🔐 KV AZDO
  prod_key_vault_resource_group = "io-p-rg-operations"
  prod_key_vault_azdo_name = "io-p-kv-azuredevops"

  # 🔐 KV Domain
  dev_idpay_key_vault_resource_group  = "${local.prefix}-d-idpay-sec-rg"
  uat_idpay_key_vault_resource_group  = "${local.prefix}-u-idpay-sec-rg"
  prod_idpay_key_vault_resource_group = "${local.prefix}-p-idpay-sec-rg"

  dev_idpay_key_vault_name  = "${local.prefix}-d-idpay-kv"
  uat_idpay_key_vault_name  = "${local.prefix}-u-idpay-kv"
  prod_idpay_key_vault_name = "${local.prefix}-p-idpay-kv"

  # 🔐 KV Domain
  dev_rtd_key_vault_resource_group  = "${local.prefix}-d-rtd-sec-rg"
  uat_rtd_key_vault_resource_group  = "${local.prefix}-u-rtd-sec-rg"
  prod_rtd_key_vault_resource_group = "${local.prefix}-p-rtd-sec-rg"

  dev_rtd_key_vault_name  = "${local.prefix}-d-rtd-kv"
  uat_rtd_key_vault_name  = "${local.prefix}-u-rtd-kv"
  prod_rtd_key_vault_name = "${local.prefix}-p-rtd-kv"
}
