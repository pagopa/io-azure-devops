provider "azuread" {
  tenant_id = module.secrets.values["PAGOPAIT-TENANTID"].value
}

locals {
  PROD-IO-UID = "${local.azure_devops_org}-${azuredevops_project.project.name}-${module.secrets.values["PAGOPAIT-PROD-IO-SUBSCRIPTION-ID"].value}"
  DEV-IO-UID  = "${local.azure_devops_org}-${azuredevops_project.project.name}-${module.secrets.values["PAGOPAIT-DEV-IO-SUBSCRIPTION-ID"].value}"
}

data "azuread_service_principal" "service_principal_PROD-IO" {
  depends_on   = [azuredevops_serviceendpoint_azurerm.PROD-IO]
  display_name = local.PROD-IO-UID
}

data "azuread_service_principal" "service_principal_DEV-IO" {
  depends_on   = [azuredevops_serviceendpoint_azurerm.DEV-IO]
  display_name = local.DEV-IO-UID
}

# Azure service connection PROD-IO
resource "azuredevops_serviceendpoint_azurerm" "PROD-IO" {
  depends_on = [azuredevops_project.project]

  project_id                = azuredevops_project.project.id
  service_endpoint_name     = "PROD-IO-SERVICE-CONN"
  description               = "PROD-IO Service connection"
  azurerm_subscription_name = "PROD-IO"
  azurerm_spn_tenantid      = module.secrets.values["PAGOPAIT-TENANTID"].value
  azurerm_subscription_id   = module.secrets.values["PAGOPAIT-PROD-IO-SUBSCRIPTION-ID"].value
}

# Azure service connection DEV-IO
resource "azuredevops_serviceendpoint_azurerm" "DEV-IO" {
  depends_on = [azuredevops_project.project]

  project_id                = azuredevops_project.project.id
  service_endpoint_name     = "DEV-IO-SERVICE-CONN"
  description               = "DEV-IO Service connection"
  azurerm_subscription_name = "DEV-IO"
  azurerm_spn_tenantid      = module.secrets.values["PAGOPAIT-TENANTID"].value
  azurerm_subscription_id   = module.secrets.values["PAGOPAIT-DEV-IO-SUBSCRIPTION-ID"].value
}

# Github service connection (read-only)
resource "azuredevops_serviceendpoint_github" "io-azure-devops-github-ro" {
  depends_on = [azuredevops_project.project]

  project_id            = azuredevops_project.project.id
  service_endpoint_name = "io-azure-devops-github-ro"
  auth_personal {
    personal_access_token = module.secrets.values["io-azure-devops-github-ro-TOKEN"].value
  }
  lifecycle {
    ignore_changes = [description, authorization]
  }
}

# Github service connection (read-write)
resource "azuredevops_serviceendpoint_github" "io-azure-devops-github-rw" {
  depends_on = [azuredevops_project.project]

  project_id            = azuredevops_project.project.id
  service_endpoint_name = "io-azure-devops-github-rw"
  auth_personal {
    personal_access_token = module.secrets.values["io-azure-devops-github-rw-TOKEN"].value
  }
  lifecycle {
    ignore_changes = [description, authorization]
  }
}

# Github service connection (pull request)
resource "azuredevops_serviceendpoint_github" "io-azure-devops-github-pr" {
  depends_on = [azuredevops_project.project]

  project_id            = azuredevops_project.project.id
  service_endpoint_name = "io-azure-devops-github-pr"
  auth_personal {
    personal_access_token = module.secrets.values["io-azure-devops-github-pr-TOKEN"].value
  }
  lifecycle {
    ignore_changes = [description, authorization]
  }
}

module "PROD-IO-TLS-CERT-SERVICE-CONN" {
  depends_on = [azuredevops_project.project]
  source     = "github.com/pagopa/azuredevops-tf-modules//azuredevops_serviceendpoint_federated?ref=v9.2.1"

  project_id        = azuredevops_project.project.id
  name              = "io-p-developer-portal-tls-cert"
  tenant_id         = module.secrets.values["PAGOPAIT-TENANTID"].value
  subscription_id   = module.secrets.values["PAGOPAIT-PROD-IO-SUBSCRIPTION-ID"].value
  subscription_name = "PROD-IO"

  location            = local.location
  resource_group_name = local.identity_rg_name
}

data "azurerm_key_vault" "kv_common" {
  provider            = azurerm.prod-io
  name                = format("%s-p-kv-common", local.prefix)
  resource_group_name = format("%s-p-rg-common", local.prefix)
}

resource "azurerm_key_vault_access_policy" "PROD-IO-TLS-CERT-SERVICE-CONN_kv_common" {
  provider     = azurerm.prod-io
  key_vault_id = data.azurerm_key_vault.kv_common.id
  tenant_id    = module.secrets.values["PAGOPAIT-TENANTID"].value
  object_id    = module.PROD-IO-TLS-CERT-SERVICE-CONN.service_principal_object_id

  certificate_permissions = ["Get", "Import"]
}

data "azurerm_key_vault" "kv" {
  provider            = azurerm.prod-io
  name                = format("%s-p-kv", local.prefix)
  resource_group_name = format("%s-p-sec-rg", local.prefix)
}

resource "azurerm_key_vault_access_policy" "PROD-IO-TLS-CERT-SERVICE-CONN_kv" {
  provider     = azurerm.prod-io
  key_vault_id = data.azurerm_key_vault.kv.id
  tenant_id    = module.secrets.values["PAGOPAIT-TENANTID"].value
  object_id    = module.PROD-IO-TLS-CERT-SERVICE-CONN.service_principal_object_id

  certificate_permissions = ["Get", "Import"]
}

# npm service connection
resource "azuredevops_serviceendpoint_npm" "pagopa-npm-bot" {
  depends_on = [azuredevops_project.project]

  project_id            = azuredevops_project.project.id
  service_endpoint_name = "pagopa-npm-bot"
  url                   = "https://registry.npmjs.org"
  access_token          = module.secrets.values["pagopa-npm-bot-TOKEN"].value
}
