variable "io-web-profile" {
  default = {
    repository = {
      organization    = "pagopa"
      name            = "io-web-profile"
      branch_name     = "refs/heads/master"
      pipelines_path  = ".devops"
      yml_prefix_name = null
    }
    pipeline = {
      enable_code_review = false
      enable_deploy      = true
    }
  }
}

locals {
  # global vars
  io-web-profile-variables = {
    DEFAULT_BRANCH = "master"
  }
  # global secrets
  io-web-profile-variables_secret = {

  }
  # code_review vars
  io-web-profile-variables_code_review = {

  }
  # code_review secrets
  io-web-profile-variables_secret_code_review = {

  }
  # deploy vars
  io-web-profile-variables_deploy = {
    PROD_AZURE_SUBSCRIPTION           = var.prod_subscription_name
    PROD_AZURE_SERVICE_CONN           = azuredevops_serviceendpoint_azurerm.PROD-IO.service_endpoint_name
    PROD_STORAGE_ACCOUNT_NAME         = replace(format("%s-p-weu-%s-portalsa", local.prefix, local.domain), "-", "")
    PROD_PROFILE_CDN_NAME             = format("%s-p-weu-%s-portal-cdn-profile", local.prefix, local.domain)
    PROD_ENDPOINT_NAME                = format("%s-p-weu-%s-portal-cdn-endpoint", local.prefix, local.domain)
    PROD_RESOURCE_GROUP_NAME          = data.azurerm_resource_group.fe_rg.name
    TF_PUBLIC_URL_SPID_LOGIN          = "https://api-web.io.pagopa.it/ioweb/auth/v1/login"
    TF_PUBLIC_URL_IO                  = "https://ioapp.it"
    TF_PUBLIC_JWT_SPID_LEVEL_VALUE_L1 = "https://www.spid.gov.it/SpidL1"
    TF_PUBLIC_JWT_SPID_LEVEL_VALUE_L2 = "https://www.spid.gov.it/SpidL2"
    TF_PUBLIC_JWT_SPID_LEVEL_VALUE_L3 = "https://www.spid.gov.it/SpidL3"
    TF_PUBLIC_API_BASE_URL            = "https://api-web.io.pagopa.it/ioweb/backend"
    TF_PUBLIC_API_BASE_PATH           = "/api/v1"
    TF_PUBLIC_API_FETCH_TIMEOUT       = 5000
    TF_PUBLIC_API_FETCH_MAX_RETRY     = 5
    TF_PUBLIC_SESSION_LIST_FF         = false
    TF_PUBLIC_CIE_ENTITY_ID           = "xx_servizicie"
    TF_PUBLIC_ANALYTICS_ENABLE        = true
    TF_PUBLIC_ANALYTICS_MOCK          = false
    // the following mixpanel project token is not a secret in any way.
    // ref -> https://developer.mixpanel.com/reference/project-token
    TF_PUBLIC_ANALYTICS_TOKEN       = "cc8f0687d3eeb055a44fff7b779ba535"
    TF_PUBLIC_ANALYTICS_API_HOST    = "https://api-eu.mixpanel.com"
    TF_PUBLIC_ANALYTICS_PERSISTENCE = "localStorage"
    TF_PUBLIC_ANALYTICS_LOG_IP      = false
    TF_PUBLIC_ANALYTICS_DEBUG       = false
    TF_PUBLIC_SPID_TEST_ENV_ENABLED = false
    TF_PUBLIC_FOOTER_PRODUCT_LIST   = "https://ioapp.it/assets/products.json"
    git_email                       = module.secrets_azdo.values["azure-devops-github-EMAIL"].value
    git_username                    = module.secrets_azdo.values["azure-devops-github-USERNAME"].value
    github_connection               = azuredevops_serviceendpoint_github.azure-devops-github-rw.service_endpoint_name
  }
  # deploy secrets
  io-web-profile-variables_secret_deploy = {

  }
}

module "io-web-profile_code_review" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_code_review?ref=v3.9.0"
  count  = var.io-web-profile.pipeline.enable_code_review == true ? 1 : 0
  path   = var.io-web-profile.repository.name

  project_id                   = azuredevops_project.project.id
  repository                   = var.io-web-profile.repository
  github_service_connection_id = azuredevops_serviceendpoint_github.azure-devops-github-pr.id

  pull_request_trigger_use_yaml = true

  variables = merge(
    local.io-web-profile-variables,
    local.io-web-profile-variables_code_review,
  )

  variables_secret = merge(
    local.io-web-profile-variables_secret,
    local.io-web-profile-variables_secret_code_review,
  )

  service_connection_ids_authorization = [
    azuredevops_serviceendpoint_github.azure-devops-github-ro.id,
  ]
}

module "io-web-profile_deploy" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_deploy?ref=v3.9.0"
  count  = var.io-web-profile.pipeline.enable_deploy == true ? 1 : 0
  path   = var.io-web-profile.repository.name

  project_id                   = azuredevops_project.project.id
  repository                   = var.io-web-profile.repository
  github_service_connection_id = azuredevops_serviceendpoint_github.azure-devops-github-pr.id

  ci_trigger_use_yaml = false

  variables = merge(
    local.io-web-profile-variables,
    local.io-web-profile-variables_deploy,
  )

  variables_secret = merge(
    local.io-web-profile-variables_secret,
    local.io-web-profile-variables_secret_deploy,
  )

  service_connection_ids_authorization = [
    azuredevops_serviceendpoint_github.azure-devops-github-ro.id,
    azuredevops_serviceendpoint_github.azure-devops-github-rw.id,
    azuredevops_serviceendpoint_azurerm.PROD-IO.id,
  ]
}
