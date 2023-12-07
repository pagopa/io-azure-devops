variable "tlscert-elk-pagopa-it" {
  default = {
    repository = {
      organization   = "pagopa"
      name           = "le-azure-acme-tiny"
      branch_name    = "refs/heads/master"
      pipelines_path = "."
    }
    pipeline = {
      enable_tls_cert = true
      path            = "TLS-Certificates"
      dns_record_name = "weubeta.elk.internal"
      dns_zone_name   = "io.pagopa.it"
      # common variables to all pipelines
      variables = {
        CERT_NAME_EXPIRE_SECONDS = "2592000" #30 days
      }
      # common secret variables to all pipelines
      variables_secret = {
      }
    }
  }
}

locals {
  tlscert-elk-pagopa-it = {
    # TODO use var.location, but currently italy north region does not support federated identities
    location                            = "westeurope"
    tenant_id                           = local.tenant_id
    subscription_name                   = local.prod.subscription_name
    subscription_id                     = local.prod.subscription_id
    dns_zone_resource_group             = local.prod.dns_zone_rg_name
    credential_subcription              = local.prod.subscription_name
    credential_key_vault_name           = local.prod.key_vault_name
    credential_key_vault_resource_group = local.prod.key_vault_rg_name
    service_connection_ids_authorization = [
      module.tls_cert_service_conn_prod.service_endpoint_id,
    ]
  }
  tlscert-elk-pagopa-it-variables = {
    KEY_VAULT_SERVICE_CONNECTION = module.tls_cert_service_conn_prod.service_endpoint_name,
    KEY_VAULT_NAME               = local.prod.key_vault_name
  }
  tlscert-elk-pagopa-it-variables_secret = {
  }
}

module "tlscert-elk-pagopa-it-cert_az" {
  depends_on = [module.letsencrypt_prod]
  count      = var.tlscert-elk-pagopa-it.pipeline.enable_tls_cert == true ? 1 : 0

  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_tls_cert_federated?ref=v4.1.3"
  providers = {
    azurerm = azurerm.prod
  }

  project_id = data.azuredevops_project.project.id
  location   = local.tlscert-elk-pagopa-it.location
  repository = var.tlscert-elk-pagopa-it.repository
  #tfsec:ignore:general-secrets-no-plaintext-exposure
  #tfsec:ignore:GEN003
  path                         = "${local.domain}\\${var.tlscert-elk-pagopa-it.pipeline.path}"
  github_service_connection_id = azuredevops_serviceendpoint_github.azure-devops-github-ro.id

  dns_record_name         = var.tlscert-elk-pagopa-it.pipeline.dns_record_name
  dns_zone_name           = var.tlscert-elk-pagopa-it.pipeline.dns_zone_name
  dns_zone_resource_group = local.tlscert-elk-pagopa-it.dns_zone_resource_group
  tenant_id               = local.tlscert-elk-pagopa-it.tenant_id
  subscription_name       = local.tlscert-elk-pagopa-it.subscription_name
  subscription_id         = local.tlscert-elk-pagopa-it.subscription_id

  credential_key_vault_name           = local.tlscert-elk-pagopa-it.credential_key_vault_name
  credential_key_vault_resource_group = local.tlscert-elk-pagopa-it.credential_key_vault_resource_group

  variables = merge(
    var.tlscert-elk-pagopa-it.pipeline.variables,
    local.tlscert-elk-pagopa-it-variables,
  )

  variables_secret = merge(
    var.tlscert-elk-pagopa-it.pipeline.variables_secret,
    local.tlscert-elk-pagopa-it-variables_secret,
  )

  service_connection_ids_authorization = local.tlscert-elk-pagopa-it.service_connection_ids_authorization

  schedules = {
    days_to_build              = ["Fri"]
    schedule_only_with_changes = false
    start_hours                = 6
    start_minutes              = 0
    time_zone                  = "(UTC+01:00) Amsterdam, Berlin, Bern, Rome, Stockholm, Vienna"
    branch_filter = {
      include = [var.tlscert-elk-pagopa-it.repository.branch_name]
      exclude = []
    }
  }
}
