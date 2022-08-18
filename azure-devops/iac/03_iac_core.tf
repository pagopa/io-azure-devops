variable "core_iac" {
  default = {
    repository = {
      organization    = "pagopa"
      name            = "io-infra"
      branch_name     = "main"
      pipelines_path  = ".devops"
      yml_prefix_name = "core"
    }
    pipeline = {
      enable_code_review   = true
      enable_deploy        = true
      path                 = "core-infrastructure"
      pipeline_name_prefix = "core-infra"
    }
  }
}

locals {
  # global vars
  iac-variables = {}
  # global secrets
  iac-variables_secret = {}

  # code_review vars
  iac-variables_code_review = {}
  # code_review secrets
  iac-variables_secret_code_review = {}

  # deploy vars
  iac-variables_deploy = {}
  # deploy secrets
  iac-variables_secret_deploy = {}
}

module "iac_code_review" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_code_review?ref=v2.6.2"
  count  = var.core_iac.pipeline.enable_code_review == true ? 1 : 0
  path   = var.core_iac.pipeline.path

  project_id                   = data.azuredevops_project.project.id
  repository                   = var.core_iac.repository
  github_service_connection_id = azuredevops_serviceendpoint_github.io-azure-devops-github-pr.id

  pipeline_name_prefix = var.core_iac.pipeline.pipeline_name_prefix

  pull_request_trigger_use_yaml = true

  variables = merge(
    local.iac-variables,
    local.iac-variables_code_review,
  )

  variables_secret = merge(
    local.iac-variables_secret,
    local.iac-variables_secret_code_review,
  )

  service_connection_ids_authorization = [
    azuredevops_serviceendpoint_github.io-azure-devops-github-ro.id,
    azuredevops_serviceendpoint_azurerm.PROD-IO.id,
    azuredevops_serviceendpoint_azurerm.PROD-IO-SIGN.id,
    azuredevops_serviceendpoint_azurerm.PROD-IO-REMINDER.id,
    azuredevops_serviceendpoint_azurerm.PROD-IO-AKS.id,
  ]
}

module "iac_deploy" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_deploy?ref=v2.6.2"
  count  = var.core_iac.pipeline.enable_deploy == true ? 1 : 0
  path   = var.core_iac.pipeline.path

  project_id                   = data.azuredevops_project.project.id
  repository                   = var.core_iac.repository
  github_service_connection_id = azuredevops_serviceendpoint_github.io-azure-devops-github-pr.id

  pipeline_name_prefix = var.core_iac.pipeline.pipeline_name_prefix

  ci_trigger_use_yaml           = true
  pull_request_trigger_use_yaml = true

  variables = merge(
    local.iac-variables,
    local.iac-variables_deploy,
  )

  variables_secret = merge(
    local.iac-variables_secret,
    local.iac-variables_secret_deploy,
  )

  service_connection_ids_authorization = [
    azuredevops_serviceendpoint_github.io-azure-devops-github-ro.id,
    azuredevops_serviceendpoint_azurerm.PROD-IO.id,
    azuredevops_serviceendpoint_azurerm.PROD-IO-SIGN.id,
    azuredevops_serviceendpoint_azurerm.PROD-IO-REMINDER.id,
    azuredevops_serviceendpoint_azurerm.PROD-IO-AKS.id,
  ]
}
