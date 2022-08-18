# PROD-SIGN service connection
resource "azuredevops_serviceendpoint_azurerm" "PROD-IO-AKS" {
  depends_on = [data.azuredevops_project.project]

  project_id                = data.azuredevops_project.project.id
  service_endpoint_name     = "PROD-IO-AKS-SERVICE-CONN"
  description               = "PROD-IO-AKS Service connection"
  azurerm_subscription_name = "PROD-IO-AKS"
  azurerm_spn_tenantid      = module.secret_azdo.values["PAGOPAIT-TENANTID"].value
  azurerm_subscription_id   = module.secret_azdo.values["PAGOPAIT-PROD-IO-SUBSCRIPTION-ID"].value
}
