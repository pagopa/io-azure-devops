variable "io-functions-service-messages" {
  default = {
    repository = {
      organization    = "pagopa"
      name            = "io-functions-service-messages"
      branch_name     = "refs/heads/master"
      pipelines_path  = ".devops"
      yml_prefix_name = null
    }
    pipeline = {
      enable_code_review = true
      enable_deploy      = true
    }
  }
}

locals {
  # global vars
  io-functions-service-messages-variables = {

  }
  # global secrets
  io-functions-service-messages-variables_secret = {

  }
  # code_review vars
  io-functions-service-messages-variables_code_review = {
    danger_github_api_token = module.secrets_azdo.values["DANGER-GITHUB-API-TOKEN"].value
    sonarcloud_service_conn = "SONARCLOUD-SERVICE-CONN"
    sonarcloud_org          = var.io-functions-service-messages.repository.organization
    sonarcloud_project_key  = "${var.io-functions-service-messages.repository.organization}_${var.io-functions-service-messages.repository.name}"
    sonarcloud_project_name = var.io-functions-service-messages.repository.name
  }
  # code_review secrets
  io-functions-service-messages-variables_secret_code_review = {

  }
  # deploy vars
  io-functions-service-messages-variables_deploy = {
    TF_NAMESPACE                            = local.domain
    TF_DOCKER_IMAGE_NAME                    = var.io-functions-service-messages.repository.name
    TF_CONTAINER_REGISTRY_FQDN_PROD         = local.docker_registry_fqdn_prod
    TF_CONTAINER_REGISTRY_SERVICE_CONN_PROD = local.srv_endpoint_name_docker_registry_prod
    TF_KUBERNETES_SERVICE_CONN_WEU_BETA     = local.srv_endpoint_name_aks_weu_beta_prod
    TF_KUBERNETES_SERVICE_CONN_WEU_PROD_01  = local.srv_endpoint_name_aks_weu_prod01_prod
    TF_KUBERNETES_SERVICE_CONN_WEU_PROD_02  = local.srv_endpoint_name_aks_weu_prod02_prod
    TF_APPINSIGHTS_SERVICE_CONN_PROD        = module.PROD-APPINSIGHTS-SERVICE-CONN.service_endpoint_name
    TF_APPINSIGHTS_RESOURCE_ID_PROD         = data.azurerm_application_insights.application_insights_prod.id
    git_email                               = module.secrets_azdo.values["azure-devops-github-EMAIL"].value
    git_username                            = module.secrets_azdo.values["azure-devops-github-USERNAME"].value
    github_connection                       = azuredevops_serviceendpoint_github.azure-devops-github-rw.service_endpoint_name
  }
  # deploy secrets
  io-functions-service-messages-variables_secret_deploy = {

  }
}

module "io-functions-service-messages_code_review" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_code_review?ref=v2.0.4"
  count  = var.io-functions-service-messages.pipeline.enable_code_review == true ? 1 : 0

  project_id                   = data.azuredevops_project.project.id
  repository                   = var.io-functions-service-messages.repository
  github_service_connection_id = azuredevops_serviceendpoint_github.azure-devops-github-pr.id

  pull_request_trigger_use_yaml = true

  variables = merge(
    local.io-functions-service-messages-variables,
    local.io-functions-service-messages-variables_code_review,
  )

  variables_secret = merge(
    local.io-functions-service-messages-variables_secret,
    local.io-functions-service-messages-variables_secret_code_review,
  )

  service_connection_ids_authorization = [
    azuredevops_serviceendpoint_github.azure-devops-github-ro.id,
    # local.azuredevops_serviceendpoint_sonarcloud_id,
  ]
}

module "io-functions-service-messages_deploy" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_deploy?ref=v2.0.4"
  count  = var.io-functions-service-messages.pipeline.enable_deploy == true ? 1 : 0

  project_id                   = data.azuredevops_project.project.id
  repository                   = var.io-functions-service-messages.repository
  github_service_connection_id = azuredevops_serviceendpoint_github.azure-devops-github-pr.id

  ci_trigger_use_yaml = false

  variables = merge(
    local.io-functions-service-messages-variables,
    local.io-functions-service-messages-variables_deploy,
  )

  variables_secret = merge(
    local.io-functions-service-messages-variables_secret,
    local.io-functions-service-messages-variables_secret_deploy,
  )

  service_connection_ids_authorization = [
    azuredevops_serviceendpoint_github.azure-devops-github-ro.id,
    azuredevops_serviceendpoint_github.azure-devops-github-rw.id,
    azuredevops_serviceendpoint_azurecr.acr_docker_registry_prod.id,
    azuredevops_serviceendpoint_kubernetes.aks-weu-beta.id,
    azuredevops_serviceendpoint_kubernetes.aks-weu-prod01.id,
    # azuredevops_serviceendpoint_kubernetes.aks-weu-prod02.id,
    module.PROD-APPINSIGHTS-SERVICE-CONN.service_endpoint_id,
  ]
}
