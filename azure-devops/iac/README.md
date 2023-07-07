<!-- markdownlint-disable -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.5 |
| <a name="requirement_azuredevops"></a> [azuredevops](#requirement\_azuredevops) | >= 0.2.2 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | <= 3.53.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuredevops"></a> [azuredevops](#provider\_azuredevops) | 0.6.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_apim_backup"></a> [apim\_backup](#module\_apim\_backup) | git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_deploy | v3.1.1 |
| <a name="module_core_iac_code_review"></a> [core\_iac\_code\_review](#module\_core\_iac\_code\_review) | git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_code_review | v3.1.1 |
| <a name="module_core_iac_deploy"></a> [core\_iac\_deploy](#module\_core\_iac\_deploy) | git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_deploy | v3.1.1 |
| <a name="module_messages_iac_code_review"></a> [messages\_iac\_code\_review](#module\_messages\_iac\_code\_review) | git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_code_review | v3.1.1 |
| <a name="module_messages_iac_deploy"></a> [messages\_iac\_deploy](#module\_messages\_iac\_deploy) | git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_deploy | v3.1.1 |
| <a name="module_messages_prod_secrets"></a> [messages\_prod\_secrets](#module\_messages\_prod\_secrets) | git::https://github.com/pagopa/terraform-azurerm-v3.git//key_vault_secrets_query | v6.20.0 |
| <a name="module_payments_iac_code_review"></a> [payments\_iac\_code\_review](#module\_payments\_iac\_code\_review) | git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_code_review | v3.1.1 |
| <a name="module_payments_iac_deploy"></a> [payments\_iac\_deploy](#module\_payments\_iac\_deploy) | git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_deploy | v3.1.1 |
| <a name="module_payments_prod_secrets"></a> [payments\_prod\_secrets](#module\_payments\_prod\_secrets) | git::https://github.com/pagopa/terraform-azurerm-v3.git//key_vault_secrets_query | v6.20.0 |
| <a name="module_profile_iac_code_review"></a> [profile\_iac\_code\_review](#module\_profile\_iac\_code\_review) | git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_code_review | v3.1.1 |
| <a name="module_profile_iac_deploy"></a> [profile\_iac\_deploy](#module\_profile\_iac\_deploy) | git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_deploy | v3.1.1 |
| <a name="module_profile_prod_secrets"></a> [profile\_prod\_secrets](#module\_profile\_prod\_secrets) | git::https://github.com/pagopa/terraform-azurerm-v3.git//key_vault_secrets_query | v6.20.0 |
| <a name="module_secret_azdo"></a> [secret\_azdo](#module\_secret\_azdo) | git::https://github.com/pagopa/terraform-azurerm-v3.git//key_vault_secrets_query | v6.20.0 |
| <a name="module_sign_iac_code_review"></a> [sign\_iac\_code\_review](#module\_sign\_iac\_code\_review) | git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_code_review | v3.1.1 |
| <a name="module_sign_iac_deploy"></a> [sign\_iac\_deploy](#module\_sign\_iac\_deploy) | git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_deploy | v3.1.1 |

## Resources

| Name | Type |
|------|------|
| [azuredevops_serviceendpoint_azurerm.PROD-IO](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/serviceendpoint_azurerm) | resource |
| [azuredevops_serviceendpoint_azurerm.PROD-IO-SIGN](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/serviceendpoint_azurerm) | resource |
| [azuredevops_serviceendpoint_github.io-azure-devops-github-pr](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/serviceendpoint_github) | resource |
| [azuredevops_serviceendpoint_github.io-azure-devops-github-ro](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/serviceendpoint_github) | resource |
| [azuredevops_project.project](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/data-sources/project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aks_platform_beta_prod_name"></a> [aks\_platform\_beta\_prod\_name](#input\_aks\_platform\_beta\_prod\_name) | Name of the aks plarfom BETA | `string` | n/a | yes |
| <a name="input_aks_platform_prod01_prod_name"></a> [aks\_platform\_prod01\_prod\_name](#input\_aks\_platform\_prod01\_prod\_name) | Name of the aks plarfom PROD01 | `string` | n/a | yes |
| <a name="input_apim_backup"></a> [apim\_backup](#input\_apim\_backup) | n/a | `map` | <pre>{<br>  "repository": {<br>    "branch_name": "refs/heads/main",<br>    "name": "io-infra",<br>    "organization": "pagopa",<br>    "pipelines_path": ".devops",<br>    "yml_prefix_name": "backup-apim"<br>  }<br>}</pre> | no |
| <a name="input_core_iac"></a> [core\_iac](#input\_core\_iac) | n/a | `map` | <pre>{<br>  "pipeline": {<br>    "enable_code_review": true,<br>    "enable_deploy": true,<br>    "path": "core-infrastructure",<br>    "pipeline_name_prefix": "core-infra"<br>  },<br>  "repository": {<br>    "branch_name": "refs/heads/main",<br>    "name": "io-infra",<br>    "organization": "pagopa",<br>    "pipelines_path": ".devops",<br>    "yml_prefix_name": "core"<br>  }<br>}</pre> | no |
| <a name="input_iac-project-name"></a> [iac-project-name](#input\_iac-project-name) | Name of the project on AZDO | `string` | n/a | yes |
| <a name="input_messages_iac"></a> [messages\_iac](#input\_messages\_iac) | n/a | `map` | <pre>{<br>  "pipeline": {<br>    "enable_code_review": true,<br>    "enable_deploy": true,<br>    "path": "messages-infrastructure",<br>    "pipeline_name_prefix": "messages-infra"<br>  },<br>  "repository": {<br>    "branch_name": "refs/heads/main",<br>    "name": "io-infra",<br>    "organization": "pagopa",<br>    "pipelines_path": ".devops",<br>    "yml_prefix_name": "messages"<br>  }<br>}</pre> | no |
| <a name="input_payments_iac"></a> [payments\_iac](#input\_payments\_iac) | n/a | `map` | <pre>{<br>  "pipeline": {<br>    "enable_code_review": true,<br>    "enable_deploy": true,<br>    "path": "payments-infrastructure",<br>    "pipeline_name_prefix": "payments-infra"<br>  },<br>  "repository": {<br>    "branch_name": "refs/heads/main",<br>    "name": "io-infra",<br>    "organization": "pagopa",<br>    "pipelines_path": ".devops",<br>    "yml_prefix_name": "payments"<br>  }<br>}</pre> | no |
| <a name="input_profile_iac"></a> [profile\_iac](#input\_profile\_iac) | n/a | `map` | <pre>{<br>  "pipeline": {<br>    "enable_code_review": true,<br>    "enable_deploy": true,<br>    "path": "profile-infrastructure",<br>    "pipeline_name_prefix": "profile-infra"<br>  },<br>  "repository": {<br>    "branch_name": "refs/heads/main",<br>    "name": "io-infra",<br>    "organization": "pagopa",<br>    "pipelines_path": ".devops",<br>    "yml_prefix_name": "profile"<br>  }<br>}</pre> | no |
| <a name="input_sign_iac"></a> [sign\_iac](#input\_sign\_iac) | n/a | `map` | <pre>{<br>  "pipeline": {<br>    "enable_code_review": true,<br>    "enable_deploy": true,<br>    "path": "sign-infrastructure",<br>    "pipeline_name_prefix": "sign-infra"<br>  },<br>  "repository": {<br>    "branch_name": "refs/heads/main",<br>    "name": "io-infra",<br>    "organization": "pagopa",<br>    "pipelines_path": ".devops",<br>    "yml_prefix_name": "sign"<br>  }<br>}</pre> | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
