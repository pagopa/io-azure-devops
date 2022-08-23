<!-- markdownlint-disable -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.5 |
| <a name="requirement_azuredevops"></a> [azuredevops](#requirement\_azuredevops) | >= 0.2.2 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | <= 2.99.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuredevops"></a> [azuredevops](#provider\_azuredevops) | 0.2.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_apim_backup"></a> [apim\_backup](#module\_apim\_backup) | git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_deploy | v2.6.2 |
| <a name="module_iac_code_review"></a> [iac\_code\_review](#module\_iac\_code\_review) | git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_code_review | v2.6.2 |
| <a name="module_iac_deploy"></a> [iac\_deploy](#module\_iac\_deploy) | git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_deploy | v2.6.2 |
| <a name="module_secret_azdo"></a> [secret\_azdo](#module\_secret\_azdo) | git::https://github.com/pagopa/azurerm.git//key_vault_secrets_query | v2.4.0 |

## Resources

| Name | Type |
|------|------|
| [azuredevops_serviceendpoint_azurerm.PROD-IO](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/serviceendpoint_azurerm) | resource |
| [azuredevops_serviceendpoint_azurerm.PROD-IO-AKS-PLATFORM](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/serviceendpoint_azurerm) | resource |
| [azuredevops_serviceendpoint_azurerm.PROD-IO-REMINDER](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/serviceendpoint_azurerm) | resource |
| [azuredevops_serviceendpoint_azurerm.PROD-IO-SIGN](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/serviceendpoint_azurerm) | resource |
| [azuredevops_serviceendpoint_github.io-azure-devops-github-pr](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/serviceendpoint_github) | resource |
| [azuredevops_serviceendpoint_github.io-azure-devops-github-ro](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/serviceendpoint_github) | resource |
| [azuredevops_project.project](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/data-sources/project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apim_backup"></a> [apim\_backup](#input\_apim\_backup) | n/a | `map` | <pre>{<br>  "repository": {<br>    "branch_name": "main",<br>    "name": "io-infra",<br>    "organization": "pagopa",<br>    "pipelines_path": ".devops",<br>    "yml_prefix_name": "backup-apim"<br>  }<br>}</pre> | no |
| <a name="input_core_iac"></a> [core\_iac](#input\_core\_iac) | n/a | `map` | <pre>{<br>  "pipeline": {<br>    "enable_code_review": true,<br>    "enable_deploy": true,<br>    "path": "core-infrastructure",<br>    "pipeline_name_prefix": "core-infra"<br>  },<br>  "repository": {<br>    "branch_name": "main",<br>    "name": "io-infra",<br>    "organization": "pagopa",<br>    "pipelines_path": ".devops",<br>    "yml_prefix_name": "core"<br>  }<br>}</pre> | no |
| <a name="input_iac-project-name"></a> [iac-project-name](#input\_iac-project-name) | Name of the project on AZDO | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
