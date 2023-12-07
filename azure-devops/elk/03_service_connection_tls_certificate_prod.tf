# create let's encrypt credential used to create SSL certificates
module "letsencrypt_prod" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3//letsencrypt_credential?ref=v7.20.0"
  providers = {
    azurerm = azurerm.prod
  }

  prefix            = local.prefix
  env               = "p"
  key_vault_name    = local.prod.key_vault_name
  subscription_name = local.prod.subscription_name
}

# create the service connection federated with a dedicated managed identityjjj
module "tls_cert_service_conn_prod" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_serviceendpoint_federated?ref=v4.0.0"
  providers = {
    azurerm = azurerm.prod
  }

  project_id          = data.azuredevops_project.project.id
  name                = "${local.prefix}-p-${local.domain}-tls-cert"
  tenant_id           = local.tenant_id
  subscription_name   = local.prod.subscription_name
  subscription_id     = local.prod.subscription_id
  location            = "westeurope" # italy north region does not support federated identities
  resource_group_name = local.prod.identity_rg_name
}

# allow the identity of the service connection to access keyvault certs
resource "azurerm_key_vault_access_policy" "tls_cert_service_conn_kv_access_policy_prod" {
  provider = azurerm.prod

  key_vault_id = data.azurerm_key_vault.kv_prod.id
  tenant_id    = local.tenant_id
  object_id    = module.tls_cert_service_conn_prod.identity_principal_id

  certificate_permissions = ["Get", "Import"]
}
