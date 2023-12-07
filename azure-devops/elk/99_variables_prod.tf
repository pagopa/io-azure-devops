locals {
  prod = {
    subscription_id   = data.azurerm_subscriptions.prod.subscriptions[0].subscription_id
    subscription_name = "PROD-IO"
    key_vault_name    = local.prod_key_vault_name
    key_vault_rg_name = local.prod_key_vault_resource_group
    dns_zone_rg_name  = local.prod_dns_zone_rg_name
    identity_rg_name  = local.prod_identity_rg_name
  }
}

