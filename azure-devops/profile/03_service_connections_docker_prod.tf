# 🛑 PROD service connection for azure container registry
resource "azuredevops_serviceendpoint_azurecr" "acr_docker_registry_prod" {
  service_endpoint_name = local.srv_endpoint_name_docker_registry_prod
  azurecr_name          = local.docker_registry_name_prod

  project_id     = data.azuredevops_project.project.id
  resource_group = local.docker_registry_rg_name_prod

  azurecr_subscription_name = var.prod_subscription_name
  azurecr_spn_tenantid      = module.secrets.values["TENANTID"].value
  azurecr_subscription_id   = module.secrets.values["PROD-SUBSCRIPTION-ID"].value
}
