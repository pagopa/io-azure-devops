# 🛑 PROD service connection for azure kubernetes service
resource "azuredevops_serviceendpoint_kubernetes" "aks-weu-prod01" {
  project_id            = data.azuredevops_project.project.id
  service_endpoint_name = local.srv_endpoint_name_aks_weu_prod01_prod
  apiserver_url         = module.secrets_prod.values["${local.prefix}-p-weu-prod01-aks-apiserver-url"].value
  authorization_type    = "ServiceAccount"
  service_account {
    # base64 values
    token   = module.secrets_prod.values["${local.prefix}-p-weu-prod01-aks-azure-devops-sa-token"].value
    ca_cert = module.secrets_prod.values["${local.prefix}-p-weu-prod01-aks-azure-devops-sa-cacrt"].value
  }
}
