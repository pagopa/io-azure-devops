#
# ⛩ Service connection 2 🔐 KV@PROD 🛑
#
#tfsec:ignore:GEN003
module "PROD-TLS-CERT-SERVICE-CONN" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_serviceendpoint_azurerm_limited?ref=v2.0.5"
  providers = {
    azurerm = azurerm.prod
  }

  project_id = data.azuredevops_project.project.id
  #tfsec:ignore:general-secrets-no-plaintext-exposure
  renew_token       = local.tlscert_renew_token
  name              = "${local.prefix}-p-${local.domain}-tls-cert"
  tenant_id         = module.secrets.values["TENANTID"].value
  subscription_id   = module.secrets.values["PROD-SUBSCRIPTION-ID"].value
  subscription_name = var.prod_subscription_name

  credential_subcription              = var.prod_subscription_name
  credential_key_vault_name           = local.prod_key_vault_name
  credential_key_vault_resource_group = local.prod_key_vault_resource_group
}

data "azurerm_key_vault" "kv_prod" {
  provider            = azurerm.prod
  name                = local.prod_key_vault_name
  resource_group_name = local.prod_key_vault_resource_group
}

resource "azurerm_key_vault_access_policy" "PROD-TLS-CERT-SERVICE-CONN_kv_prod" {
  provider     = azurerm.prod
  key_vault_id = data.azurerm_key_vault.kv_prod.id
  tenant_id    = module.secrets.values["TENANTID"].value
  object_id    = module.PROD-TLS-CERT-SERVICE-CONN.service_principal_object_id

  certificate_permissions = ["Get", "Import"]
}

# create let's encrypt credential used to create SSL certificates
resource "null_resource" "letsencrypt_prod" {
  triggers = {
    prefix        = local.prefix
    env_short     = "p"
    subscription  = var.prod_subscription_name
    keyvault_name = local.prod_key_vault_name
    email         = local.le_email
  }

  # https://docs.microsoft.com/it-it/cli/azure/ad/sp?view=azure-cli-latest#az_ad_sp_create_for_rbac
  provisioner "local-exec" {
    command = <<EOT
      container_name="le${self.triggers.prefix}${self.triggers.env_short}"

      docker run --name $container_name certbot/certbot register --agree-tos --email "${self.triggers.email}" -n

      mkdir -p ./accounts/${self.triggers.prefix}${self.triggers.env_short}
      docker cp $container_name:/etc/letsencrypt/accounts/ ./accounts/${self.triggers.prefix}${self.triggers.env_short}

      docker rm -v $container_name

      private_key_json=$(find ./accounts/${self.triggers.prefix}${self.triggers.env_short} -name "private_key.json")

      az keyvault secret set \
        --name "le-private-key-json" \
        --vault-name "${self.triggers.keyvault_name}" \
        --subscription "${self.triggers.subscription}" \
        --file "$private_key_json"

      reg_json=$(find ./accounts/${self.triggers.prefix}${self.triggers.env_short} -name "regr.json")

      az keyvault secret set \
        --name "le-regr-json" \
        --vault-name "${self.triggers.keyvault_name}" \
        --subscription "${self.triggers.subscription}" \
        --file "$reg_json"

      rm -rf accounts/${self.triggers.prefix}${self.triggers.env_short}

    EOT
  }
}
