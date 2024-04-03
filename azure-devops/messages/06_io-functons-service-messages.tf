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
      production_resource_group_name = "io-p-service-messages-rg"
      production_app_name            = "io-p-messages-sending-func"
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
    git_email                               = module.secrets_azdo.values["azure-devops-github-EMAIL"].value
    git_username                            = module.secrets_azdo.values["azure-devops-github-USERNAME"].value
    github_connection                       = azuredevops_serviceendpoint_github.azure-devops-github-rw.service_endpoint_name
    PRODUCTION_AZURE_SUBSCRIPTION = azuredevops_serviceendpoint_azurerm.PROD-IO.service_endpoint_name
    PRODUCTION_RESOURCE_GROUP_NAME = var.io-functions-service-messages.pipeline.production_resource_group_name
    PRODUCTION_APP_NAME = var.io-functions-service-messages.pipeline.production_app_name
    AGENT_POOL = "io-prod-linux"
  }
  # deploy secrets
  io-functions-service-messages-variables_secret_deploy = {

  }
}

module "io-functions-service-messages_code_review" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_code_review?ref=v3.1.1"
  count  = var.io-functions-service-messages.pipeline.enable_code_review == true ? 1 : 0
  path   = var.io-functions-service-messages.repository.name

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
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_deploy?ref=v3.1.1"
  count  = var.io-functions-service-messages.pipeline.enable_deploy == true ? 1 : 0
  path   = var.io-functions-service-messages.repository.name

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
    module.PROD-APPINSIGHTS-SERVICE-CONN.service_endpoint_id,
  ]
}
