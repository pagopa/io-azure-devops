# PROD-SIGN service connection
resource "azuredevops_serviceendpoint_azurerm" "PROD-IO-SIGN" {
  depends_on = [data.azuredevops_project.project]

  project_id                = data.azuredevops_project.project.id
  service_endpoint_name     = "PROD-IO-SIGN-SERVICE-CONN"
  description               = "PROD-IO-SIGN Service connection"
  azurerm_subscription_name = "PROD-IO-SIGN"
  azurerm_spn_tenantid      = module.secret_azdo.values["PAGOPAIT-TENANTID"].value
  azurerm_subscription_id   = module.secret_azdo.values["PAGOPAIT-PROD-IO-SUBSCRIPTION-ID"].value
}
