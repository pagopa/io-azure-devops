locals {
  tenant_id = data.azurerm_client_config.current.tenant_id


  # TODO azure devops terraform provider does not support SonarCloud service endpoint
  azuredevops_serviceendpoint_sonarcloud_id = "9182be64-d387-465d-9acc-e79e802910c8"
}

variable "project_name_prefix" {
  type        = string
  description = "Project name prefix (e.g. userregistry)"
}

locals {
  prefix           = "io"
  azure_devops_org = "pagopaspa"
  domain           = "elk"

  prod_subscription_name = "PROD-IO"
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
  prod_dns_zone_rg_name = "${local.prefix}-p-rg-external"
  prod_identity_rg_name = "${local.prefix}-p-${local.domain}-weu-beta-rg"

  # 📦 ACR PROD DOCKER
  srv_endpoint_name_docker_registry_prod = "${local.prefix}-p-${local.domain}-acr-docker-registry-prod"
  docker_registry_rg_name_prod           = "${local.prefix}-p-container-registry-rg"
  docker_registry_name_prod              = "${local.prefix}pcommonacr"
  docker_registry_fqdn_prod              = "${local.docker_registry_name_prod}.azurecr.io"

  srv_endpoint_name_aks_weu_beta_prod   = "${local.prefix}-${local.domain}-aks-weu-beta"
  srv_endpoint_name_aks_weu_prod01_prod = "${local.prefix}-${local.domain}-aks-weu-prod01"
  srv_endpoint_name_aks_weu_prod02_prod = "${local.prefix}-${local.domain}-aks-weu-prod02"

  #tfsec:ignore:general-secrets-no-plaintext-exposure
  #tfsec:ignore:GEN002
  tlscert_renew_token = "v2"

  appinsights_renew_token = "v1"

  # dev_appinsights_name           = "${local.prefix}-d-ai-common"
  # uat_appinsights_name           = "${local.prefix}-u-ai-common"
  prod_appinsights_name = "${local.prefix}-p-ai-common"

  # dev_appinsights_resource_group = "${local.prefix}-d-rg-common"
  # uat_appinsights_resource_group = "${local.prefix}-u-rg-common"
  prod_appinsights_resource_group = "${local.prefix}-p-rg-common"
}
