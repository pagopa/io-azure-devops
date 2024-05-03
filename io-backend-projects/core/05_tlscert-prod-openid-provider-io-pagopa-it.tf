variable "tlscert-openid-provider-io-pagopa-it" {
  default = {
    repository = {
      organization   = "pagopa"
      name           = "le-azure-acme-tiny"
      branch_name    = "refs/heads/master"
      pipelines_path = "."
    }
    pipeline = {
      enable_tls_cert         = true
      path                    = "TLS-Certificates\\PROD"
      dns_record_name         = "openid-provider"
      dns_zone_name           = "io.pagopa.it"
      dns_zone_resource_group = "io-p-rg-external"
      # common variables to all pipelines
      variables = {
        CERT_NAME_EXPIRE_SECONDS = "2592000" #30 days
        KEY_VAULT_NAME           = "io-p-kv"
        RESOURCE_GROUP_NAME      = "io-p-sec-rg"
      }
      # common secret variables to all pipelines
      variables_secret = {
      }
    }
  }
}

locals {
  tlscert-openid-provider-io-pagopa-it = {
    tenant_id         = data.azurerm_client_config.current.tenant_id
    subscription_name = var.prod_subscription_name
    subscription_id   = data.azurerm_subscription.current.subscription_id
  }
  tlscert-openid-provider-io-pagopa-it-variables = {
    KEY_VAULT_CERT_NAME          = "${replace(var.tlscert-openid-provider-io-pagopa-it.pipeline.dns_record_name, ".", "-")}-${replace(var.tlscert-openid-provider-io-pagopa-it.pipeline.dns_zone_name, ".", "-")}"
    KEY_VAULT_SERVICE_CONNECTION = module.PROD-TLS-CERT-SERVICE-CONN.service_endpoint_name,
  }
  tlscert-openid-provider-io-pagopa-it-variables_secret = {
  }
}

module "tlscert-openid-provider-io-pagopa-it-cert_az" {
  source = "github.com/pagopa/azuredevops-tf-modules//azuredevops_build_definition_tls_cert_federated?ref=v7.2.0"
  count  = var.tlscert-openid-provider-io-pagopa-it.pipeline.enable_tls_cert == true ? 1 : 0

  project_id                   = azuredevops_project.project.id
  repository                   = var.tlscert-openid-provider-io-pagopa-it.repository
  path                         = "${local.domain}\\${var.tlscert-openid-provider-io-pagopa-it.pipeline.path}"
  github_service_connection_id = azuredevops_serviceendpoint_github.azure-devops-github-rw.id

  dns_record_name                      = var.tlscert-openid-provider-io-pagopa-it.pipeline.dns_record_name
  dns_zone_name                        = var.tlscert-openid-provider-io-pagopa-it.pipeline.dns_zone_name
  dns_zone_resource_group              = var.tlscert-openid-provider-io-pagopa-it.pipeline.dns_zone_resource_group
  tenant_id                            = local.tlscert-openid-provider-io-pagopa-it.tenant_id
  subscription_name                    = local.tlscert-openid-provider-io-pagopa-it.subscription_name
  subscription_id                      = local.tlscert-openid-provider-io-pagopa-it.subscription_id
  managed_identity_resource_group_name = local.identity_rg_name

  location                            = local.location
  credential_key_vault_name           = var.tlscert-openid-provider-io-pagopa-it.pipeline.variables.KEY_VAULT_NAME
  credential_key_vault_resource_group = var.tlscert-openid-provider-io-pagopa-it.pipeline.variables.RESOURCE_GROUP_NAME

  variables = merge(
    var.tlscert-openid-provider-io-pagopa-it.pipeline.variables,
    local.tlscert-openid-provider-io-pagopa-it-variables,
  )

  variables_secret = merge(
    var.tlscert-openid-provider-io-pagopa-it.pipeline.variables_secret,
    local.tlscert-openid-provider-io-pagopa-it-variables_secret,
  )

  service_connection_ids_authorization = [
    module.PROD-TLS-CERT-SERVICE-CONN.service_endpoint_id,
  ]

  schedules = {
    days_to_build              = ["Thu"]
    schedule_only_with_changes = false
    start_hours                = 7
    start_minutes              = 0
    time_zone                  = "(UTC+01:00) Amsterdam, Berlin, Bern, Rome, Stockholm, Vienna"
    branch_filter = {
      include = ["master"]
      exclude = []
    }
  }
}
