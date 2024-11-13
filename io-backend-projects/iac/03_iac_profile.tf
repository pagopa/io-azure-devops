variable "profile_iac" {
  default = {
    repository = {
      organization    = "pagopa"
      name            = "io-infra"
      branch_name     = "refs/heads/main"
      pipelines_path  = ".devops"
      yml_prefix_name = "profile"
    }
    pipeline = {
      enable_code_review   = true
      enable_deploy        = true
      path                 = "profile-infrastructure"
      pipeline_name_prefix = "profile-infra"
    }
  }
}

locals {
  # global vars
  profile-iac-variables = {
    tf_prod01_aks_apiserver_url         = module.profile_prod_secrets.values["io-p-weu-prod01-aks-apiserver-url"].value,
    tf_prod01_aks_azure_devops_sa_cacrt = module.profile_prod_secrets.values["io-p-weu-prod01-aks-azure-devops-sa-cacrt"].value,
    tf_prod01_aks_azure_devops_sa_token = base64decode(module.profile_prod_secrets.values["io-p-weu-prod01-aks-azure-devops-sa-token"].value),
    tf_aks_platform_prod01_prod_name    = var.aks_platform_prod01_prod_name
  }
  # global secrets
  profile-iac-variables_secret = {}

  # code_review vars
  profile-iac-variables_code_review = {}
  # code_review secrets
  profile-iac-variables_secret_code_review = {}

  # deploy vars
  profile-iac-variables_deploy = {}
  # deploy secrets
  profile-iac-variables_secret_deploy = {}
}

module "profile_iac_code_review" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_code_review?ref=v3.1.1"
  count  = var.profile_iac.pipeline.enable_code_review == true ? 1 : 0
  path   = var.profile_iac.pipeline.path

  project_id                   = data.azuredevops_project.project.id
  repository                   = var.profile_iac.repository
  github_service_connection_id = azuredevops_serviceendpoint_github.io-azure-devops-github-pr.id

  pipeline_name_prefix = var.profile_iac.pipeline.pipeline_name_prefix

  pull_request_trigger_use_yaml = true

  variables = merge(
    local.profile-iac-variables,
    local.profile-iac-variables_code_review,
  )

  variables_secret = merge(
    local.profile-iac-variables_secret,
    local.profile-iac-variables_secret_code_review,
  )

  service_connection_ids_authorization = [
    azuredevops_serviceendpoint_github.io-azure-devops-github-ro.id,
    azuredevops_serviceendpoint_azurerm.PROD-IO.id,
  ]
}

module "profile_iac_deploy" {
  source = "github.com/pagopa/azuredevops-tf-modules//azuredevops_build_definition_deploy?ref=v7.2.0"
  count  = var.profile_iac.pipeline.enable_deploy == true ? 1 : 0
  path   = var.profile_iac.pipeline.path

  project_id                   = data.azuredevops_project.project.id
  repository                   = var.profile_iac.repository
  github_service_connection_id = azuredevops_serviceendpoint_github.io-azure-devops-github-pr.id

  pipeline_name_prefix = var.profile_iac.pipeline.pipeline_name_prefix

  ci_trigger_use_yaml           = true
  pull_request_trigger_use_yaml = true

  variables = merge(
    local.profile-iac-variables,
    local.profile-iac-variables_deploy,
  )

  variables_secret = merge(
    local.profile-iac-variables_secret,
    local.profile-iac-variables_secret_deploy,
  )

  service_connection_ids_authorization = [
    azuredevops_serviceendpoint_github.io-azure-devops-github-ro.id,
    azuredevops_serviceendpoint_azurerm.PROD-IO.id,
  ]
}
