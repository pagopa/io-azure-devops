<!-- markdownlint-disable -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_azuredevops"></a> [azuredevops](#requirement\_azuredevops) | >= 0.2.2 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | <= 3.53.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuredevops"></a> [azuredevops](#provider\_azuredevops) | 0.11.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.53.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_secret_azdo"></a> [secret\_azdo](#module\_secret\_azdo) | github.com/pagopa/terraform-azurerm-v3//key_vault_secrets_query | v8.9.0 |
| <a name="module_sign_iac_code_review"></a> [sign\_iac\_code\_review](#module\_sign\_iac\_code\_review) | git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_code_review | v3.1.1 |
| <a name="module_sign_iac_deploy"></a> [sign\_iac\_deploy](#module\_sign\_iac\_deploy) | github.com/pagopa/azuredevops-tf-modules//azuredevops_build_definition_deploy | v7.2.0 |

## Resources

| Name | Type |
|------|------|
| [azuredevops_serviceendpoint_azurerm.PROD-IO](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/serviceendpoint_azurerm) | resource |
| [azuredevops_serviceendpoint_github.io-azure-devops-github-pr](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/serviceendpoint_github) | resource |
| [azuredevops_serviceendpoint_github.io-azure-devops-github-ro](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/serviceendpoint_github) | resource |
| [azuredevops_project.project](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/data-sources/project) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aks_platform_prod01_prod_name"></a> [aks\_platform\_prod01\_prod\_name](#input\_aks\_platform\_prod01\_prod\_name) | Name of the aks plarfom PROD01 | `string` | n/a | yes |
| <a name="input_iac-project-name"></a> [iac-project-name](#input\_iac-project-name) | Name of the project on AZDO | `string` | n/a | yes |
| <a name="input_sign_iac"></a> [sign\_iac](#input\_sign\_iac) | n/a | `map` | <pre>{<br/>  "pipeline": {<br/>    "enable_code_review": true,<br/>    "enable_deploy": true,<br/>    "path": "sign-infrastructure",<br/>    "pipeline_name_prefix": "sign-infra"<br/>  },<br/>  "repository": {<br/>    "branch_name": "refs/heads/main",<br/>    "name": "io-infra",<br/>    "organization": "pagopa",<br/>    "pipelines_path": ".devops",<br/>    "yml_prefix_name": "sign"<br/>  }<br/>}</pre> | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
