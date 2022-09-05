variable "sign_iac" {
  default = {
    repository = {
      organization    = "pagopa"
      name            = "io-infra"
      branch_name     = "refs/heads/main"
      pipelines_path  = ".devops"
      yml_prefix_name = "sign"
    }
    pipeline = {
      enable_code_review   = true
      enable_deploy        = true
      path                 = "sign-infrastructure"
      pipeline_name_prefix = "sign-infra"
    }
  }
}

locals {
  # global vars
  sign-iac-variables = {
    # tf_beta_aks_apiserver_url           = module.sign_prod_secrets.values["io-p-weu-beta-aks-apiserver-url"].value,
    # tf_beta_aks_azure_devops_sa_cacrt   = module.sign_prod_secrets.values["io-p-weu-beta-aks-azure-devops-sa-cacrt"].value,
    # tf_beta_aks_azure_devops_sa_token   = base64decode(module.sign_prod_secrets.values["io-p-weu-beta-aks-azure-devops-sa-token"].value),
    # tf_prod01_aks_apiserver_url         = module.sign_prod_secrets.values["io-p-weu-prod01-aks-apiserver-url"].value,
    # tf_prod01_aks_azure_devops_sa_cacrt = module.sign_prod_secrets.values["io-p-weu-prod01-aks-azure-devops-sa-cacrt"].value,
    # tf_prod01_aks_azure_devops_sa_token = base64decode(module.sign_prod_secrets.values["io-p-weu-prod01-aks-azure-devops-sa-token"].value),
    # tf_aks_platform_beta_prod_name      = var.aks_platform_beta_prod_name
    # tf_aks_platform_prod01_prod_name    = var.aks_platform_prod01_prod_name
  }
  # global secrets
  sign-iac-variables_secret = {}

  # code_review vars
  sign-iac-variables_code_review = {}
  # code_review secrets
  sign-iac-variables_secret_code_review = {}

  # deploy vars
  sign-iac-variables_deploy = {}
  # deploy secrets
  sign-iac-variables_secret_deploy = {}
}

module "sign_iac_code_review" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_code_review?ref=v2.6.2"
  count  = var.sign_iac.pipeline.enable_code_review == true ? 1 : 0
  path   = var.sign_iac.pipeline.path

  project_id                   = data.azuredevops_project.project.id
  repository                   = var.sign_iac.repository
  github_service_connection_id = azuredevops_serviceendpoint_github.io-azure-devops-github-pr.id

  pipeline_name_prefix = var.sign_iac.pipeline.pipeline_name_prefix

  pull_request_trigger_use_yaml = true

  variables = merge(
    local.sign-iac-variables,
    local.sign-iac-variables_code_review,
  )

  variables_secret = merge(
    local.sign-iac-variables_secret,
    local.sign-iac-variables_secret_code_review,
  )

  service_connection_ids_authorization = [
    azuredevops_serviceendpoint_github.io-azure-devops-github-ro.id,
    azuredevops_serviceendpoint_azurerm.PROD-IO.id,
  ]
}

module "sign_iac_deploy" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_deploy?ref=v2.6.2"
  count  = var.sign_iac.pipeline.enable_deploy == true ? 1 : 0
  path   = var.sign_iac.pipeline.path

  project_id                   = data.azuredevops_project.project.id
  repository                   = var.sign_iac.repository
  github_service_connection_id = azuredevops_serviceendpoint_github.io-azure-devops-github-pr.id

  pipeline_name_prefix = var.sign_iac.pipeline.pipeline_name_prefix

  ci_trigger_use_yaml           = true
  pull_request_trigger_use_yaml = true

  variables = merge(
    local.sign-iac-variables,
    local.sign-iac-variables_deploy,
  )

  variables_secret = merge(
    local.sign-iac-variables_secret,
    local.sign-iac-variables_secret_deploy,
  )

  service_connection_ids_authorization = [
    azuredevops_serviceendpoint_github.io-azure-devops-github-ro.id,
    azuredevops_serviceendpoint_azurerm.PROD-IO.id,
  ]
}
