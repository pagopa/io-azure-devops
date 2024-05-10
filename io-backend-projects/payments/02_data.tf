data "azurerm_key_vault" "kv_prod" {
  name                = local.prod_key_vault_name
  resource_group_name = local.prod_key_vault_resource_group
}
