variable "io-web-profile-backend" {
  default = {
    repository = {
      organization    = "pagopa"
      name            = "io-web-profile-backend"
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
  io-web-profile-backend-variables = {

  }
  # global secrets
  io-web-profile-backend-variables_secret = {

  }
  # code_review vars
  io-web-profile-backend-variables_code_review = {

  }
  # code_review secrets
  io-web-profile-backend-variables_secret_code_review = {

  }
  # deploy vars
  io-web-profile-backend-variables_deploy = {
    PROD_AZURE_SUBSCRIPTION  = var.prod_subscription_name
    PROD_RESOURCE_GROUP_NAME = data.azurerm_resource_group.common_rg.name
    PROD_APP_NAME            = format("%s-p-%s-%s-profile-fn", local.prefix, local.location, local.domain)
    AGENT_POOL               = local.agent_pool
    git_email                = module.secrets_azdo.values["azure-devops-github-EMAIL"].value
    git_username             = module.secrets_azdo.values["azure-devops-github-USERNAME"].value
    github_connection        = azuredevops_serviceendpoint_github.azure-devops-github-rw.service_endpoint_name
  }
  # deploy secrets
  io-web-profile-backend-variables_secret_deploy = {

  }
}

module "io-web-profile-backend_code_review" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_code_review?ref=v3.9.0"
  count  = var.io-web-profile-backend.pipeline.enable_code_review == true ? 1 : 0
  path   = var.io-web-profile-backend.repository.name

  project_id                   = data.azuredevops_project.project.id
  repository                   = var.io-web-profile-backend.repository
  github_service_connection_id = azuredevops_serviceendpoint_github.azure-devops-github-pr.id

  pull_request_trigger_use_yaml = true

  variables = merge(
    local.io-web-profile-backend-variables,
    local.io-web-profile-backend-variables_code_review,
  )

  variables_secret = merge(
    local.io-web-profile-backend-variables_secret,
    local.io-web-profile-backend-variables_secret_code_review,
  )

  service_connection_ids_authorization = [
    azuredevops_serviceendpoint_github.azure-devops-github-ro.id,
  ]
}

module "io-web-profile-backend_deploy" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_deploy?ref=v3.9.0"
  count  = var.io-web-profile-backend.pipeline.enable_deploy == true ? 1 : 0
  path   = var.io-web-profile-backend.repository.name

  project_id                   = data.azuredevops_project.project.id
  repository                   = var.io-web-profile-backend.repository
  github_service_connection_id = azuredevops_serviceendpoint_github.azure-devops-github-pr.id

  ci_trigger_use_yaml = false

  variables = merge(
    local.io-web-profile-backend-variables,
    local.io-web-profile-backend-variables_deploy,
  )

  variables_secret = merge(
    local.io-web-profile-backend-variables_secret,
    local.io-web-profile-backend-variables_secret_deploy,
  )

  service_connection_ids_authorization = [
    azuredevops_serviceendpoint_github.azure-devops-github-ro.id,
    azuredevops_serviceendpoint_github.azure-devops-github-rw.id,
  ]
}
