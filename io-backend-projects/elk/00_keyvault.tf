
data "azurerm_key_vault" "kv_prod" {
  provider = azurerm.prod

  resource_group_name = local.prod.key_vault_rg_name
  name                = local.prod.key_vault_name
}
