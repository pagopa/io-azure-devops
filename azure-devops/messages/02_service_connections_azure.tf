#
# ⛩ Service connections
#

# PROD service connection
resource "azuredevops_serviceendpoint_azurerm" "PROD-IO" {
  depends_on = [azuredevops_project.project]

  project_id                = azuredevops_project.project.id
  service_endpoint_name     = "PROD-IO-SERVICE-CONN"
  description               = "PROD-IO Service connection"
  azurerm_subscription_name = "PROD-IO"
  azurerm_spn_tenantid      = module.secrets_azdo.values["TENANTID"].value
  azurerm_subscription_id   = module.secrets_azdo.values["PROD-SUBSCRIPTION-ID"].value
}
