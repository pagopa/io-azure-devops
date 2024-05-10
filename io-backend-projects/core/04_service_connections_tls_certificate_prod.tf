#
# ⛩ Service connection 2 🔐 KV@PROD 🛑
#
#tfsec:ignore:GEN003
module "PROD-TLS-AZDO-CERT-SERVICE-CONN" {
  source = "github.com/pagopa/azuredevops-tf-modules//azuredevops_serviceendpoint_federated?ref=v7.2.0"

  project_id          = azuredevops_project.project.id
  name                = "${local.prefix}-p-${local.domain}-tls-azdo-cert"
  tenant_id           = data.azurerm_client_config.current.tenant_id
  subscription_id     = data.azurerm_subscription.current.subscription_id
  subscription_name   = var.prod_subscription_name
  location            = local.location
  resource_group_name = local.identity_rg_name
}

resource "azurerm_key_vault_access_policy" "PROD-TLS-AZDO-CERT-SERVICE-CONN_kv_prod" {
  key_vault_id = data.azurerm_key_vault.kv_prod.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = module.PROD-TLS-AZDO-CERT-SERVICE-CONN.service_principal_object_id

  certificate_permissions = ["Get", "Import"]
}

resource "azurerm_key_vault_access_policy" "PROD-TLS-AZDO-CERT-SERVICE-CONN_kv_common_prod" {
  key_vault_id = data.azurerm_key_vault.kv_common_prod.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = module.PROD-TLS-AZDO-CERT-SERVICE-CONN.service_principal_object_id

  certificate_permissions = ["Get", "Import"]
}

module "PROD-TLS-CERT-SERVICE-CONN" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_serviceendpoint_azurerm_limited?ref=v3.1.1"

  project_id = azuredevops_project.project.id
  #tfsec:ignore:general-secrets-no-plaintext-exposure
  renew_token       = local.tlscert_renew_token
  name              = "${local.prefix}-p-${local.domain}-tls-cert"
  tenant_id         = data.azurerm_client_config.current.tenant_id
  subscription_id   = data.azurerm_subscription.current.subscription_id
  subscription_name = var.prod_subscription_name

  credential_subcription              = var.prod_subscription_name
  credential_key_vault_name           = local.prod_key_vault_name
  credential_key_vault_resource_group = local.prod_key_vault_resource_group
}

resource "azurerm_key_vault_access_policy" "PROD-TLS-CERT-SERVICE-CONN_kv_prod" {
  key_vault_id = data.azurerm_key_vault.kv_prod.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = module.PROD-TLS-CERT-SERVICE-CONN.service_principal_object_id

  certificate_permissions = ["Get", "Import"]
}

resource "azurerm_key_vault_access_policy" "PROD-TLS-CERT-SERVICE-CONN_kv_prod_common" {
  key_vault_id = data.azurerm_key_vault.kv_common_prod.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = module.PROD-TLS-CERT-SERVICE-CONN.service_principal_object_id

  certificate_permissions = ["Get", "Import"]
}

# create let's encrypt credential used to create SSL certificates
module "letsencrypt_prod" {
  source = "github.com/pagopa/terraform-azurerm-v3//letsencrypt_credential?ref=v6.20.0"

  prefix            = local.prefix
  env               = "p"
  key_vault_name    = local.prod_key_vault_name
  subscription_name = var.prod_subscription_name
}
