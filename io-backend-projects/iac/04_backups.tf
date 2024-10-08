variable "apim_backup" {
  default = {
    repository = {
      organization    = "pagopa"
      name            = "io-infra"
      branch_name     = "refs/heads/main"
      pipelines_path  = ".devops"
      yml_prefix_name = "backup-apim"
    }
  }
}

module "apim_backup" {
  source = "github.com/pagopa/azuredevops-tf-modules//azuredevops_build_definition_deploy?ref=v7.2.0"

  project_id                   = data.azuredevops_project.project.id
  repository                   = var.apim_backup.repository
  github_service_connection_id = azuredevops_serviceendpoint_github.io-azure-devops-github-pr.id
  path                         = "backups"
  pipeline_name_prefix         = "backup-apim"

  ci_trigger_use_yaml           = false
  pull_request_trigger_use_yaml = true

  variables = {
    apim_name                 = "io-p-apim-v2-api"
    apim_rg                   = "io-p-rg-internal"
    storage_account_name      = "iopstbackups"
    backup_name               = "apim-backup"
    storage_account_container = "apimbackup"
    storage_account_rg        = "io-p-rg-operations"
  }

  variables_secret = {}

  service_connection_ids_authorization = [
    azuredevops_serviceendpoint_azurerm.PROD-IO.id,
  ]

  schedules = {
    days_to_build              = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    schedule_only_with_changes = false
    start_hours                = 7
    start_minutes              = 20
    time_zone                  = "(UTC+01:00) Amsterdam, Berlin, Bern, Rome, Stockholm, Vienna"
    branch_filter = {
      include = ["main"]
      exclude = []
    }
  }
}
