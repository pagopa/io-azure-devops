#
# ⛩ Service connection 2 🔐 KV@PROD 🛑
#

module "PROD-TLS-AZDO-CERT-SERVICE-CONN" {
  source = "github.com/pagopa/azuredevops-tf-modules//azuredevops_serviceendpoint_federated?ref=v7.2.0"

  project_id          = data.azuredevops_project.project.id
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

# create let's encrypt credential used to create SSL certificates
module "letsencrypt_prod" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//letsencrypt_credential?ref=v6.20.0"

  prefix            = local.prefix
  env               = "p"
  key_vault_name    = local.prod_key_vault_name
  subscription_name = var.prod_subscription_name
}
