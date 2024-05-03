<!-- markdownlint-disable -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_azuredevops"></a> [azuredevops](#requirement\_azuredevops) | <= 0.10.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | <= 3.100.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuredevops"></a> [azuredevops](#provider\_azuredevops) | 0.10.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.53.0 |
| <a name="provider_azurerm.prod"></a> [azurerm.prod](#provider\_azurerm.prod) | 3.53.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_PROD-APPINSIGHTS-SERVICE-CONN"></a> [PROD-APPINSIGHTS-SERVICE-CONN](#module\_PROD-APPINSIGHTS-SERVICE-CONN) | git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_serviceendpoint_azurerm_limited | v3.1.1 |
| <a name="module_PROD-TLS-CERT-SERVICE-CONN"></a> [PROD-TLS-CERT-SERVICE-CONN](#module\_PROD-TLS-CERT-SERVICE-CONN) | git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_serviceendpoint_azurerm_limited | v3.1.1 |
| <a name="module_io-functions-service-messages_code_review"></a> [io-functions-service-messages\_code\_review](#module\_io-functions-service-messages\_code\_review) | git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_code_review | v3.1.1 |
| <a name="module_io-functions-service-messages_deploy"></a> [io-functions-service-messages\_deploy](#module\_io-functions-service-messages\_deploy) | git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_deploy | v3.1.1 |
| <a name="module_io-premium-reminder-ms_code_review"></a> [io-premium-reminder-ms\_code\_review](#module\_io-premium-reminder-ms\_code\_review) | git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_code_review | v3.1.1 |
| <a name="module_io-premium-reminder-ms_deploy"></a> [io-premium-reminder-ms\_deploy](#module\_io-premium-reminder-ms\_deploy) | git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_deploy | v3.1.1 |
| <a name="module_letsencrypt_prod"></a> [letsencrypt\_prod](#module\_letsencrypt\_prod) | git::https://github.com/pagopa/terraform-azurerm-v3.git//letsencrypt_credential | v6.20.0 |
| <a name="module_secrets_azdo"></a> [secrets\_azdo](#module\_secrets\_azdo) | git::https://github.com/pagopa/terraform-azurerm-v3.git//key_vault_secrets_query | v6.20.0 |
| <a name="module_secrets_prod"></a> [secrets\_prod](#module\_secrets\_prod) | git::https://github.com/pagopa/terraform-azurerm-v3.git//key_vault_secrets_query | v6.20.0 |
| <a name="module_tlscert-prod-weubeta-messages-internal-io-pagopa-it-cert_az"></a> [tlscert-prod-weubeta-messages-internal-io-pagopa-it-cert\_az](#module\_tlscert-prod-weubeta-messages-internal-io-pagopa-it-cert\_az) | github.com/pagopa/azuredevops-tf-modules//azuredevops_build_definition_tls_cert_federated | v7.2.0 |
| <a name="module_tlscert-prod-weuprod01-messages-internal-io-pagopa-it-cert_az"></a> [tlscert-prod-weuprod01-messages-internal-io-pagopa-it-cert\_az](#module\_tlscert-prod-weuprod01-messages-internal-io-pagopa-it-cert\_az) | github.com/pagopa/azuredevops-tf-modules//azuredevops_build_definition_tls_cert_federated | v7.2.0 |

## Resources

| Name | Type |
|------|------|
| [azuredevops_serviceendpoint_azurecr.acr_docker_registry_prod](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/serviceendpoint_azurecr) | resource |
| [azuredevops_serviceendpoint_github.azure-devops-github-pr](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/serviceendpoint_github) | resource |
| [azuredevops_serviceendpoint_github.azure-devops-github-ro](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/serviceendpoint_github) | resource |
| [azuredevops_serviceendpoint_github.azure-devops-github-rw](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/serviceendpoint_github) | resource |
| [azuredevops_serviceendpoint_kubernetes.aks-weu-beta](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/serviceendpoint_kubernetes) | resource |
| [azuredevops_serviceendpoint_kubernetes.aks-weu-prod01](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/serviceendpoint_kubernetes) | resource |
| [azurerm_key_vault_access_policy.PROD-TLS-CERT-SERVICE-CONN_kv_prod](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_role_assignment.appinsights_component_contributor_prod](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azuredevops_project.project](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/data-sources/project) | data source |
| [azurerm_application_insights.application_insights_prod](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/application_insights) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_key_vault.kv_prod](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_io-functions-service-messages"></a> [io-functions-service-messages](#input\_io-functions-service-messages) | n/a | `map` | <pre>{<br>  "pipeline": {<br>    "enable_code_review": true,<br>    "enable_deploy": true<br>  },<br>  "repository": {<br>    "branch_name": "refs/heads/master",<br>    "name": "io-functions-service-messages",<br>    "organization": "pagopa",<br>    "pipelines_path": ".devops",<br>    "yml_prefix_name": null<br>  }<br>}</pre> | no |
| <a name="input_io-premium-reminder-ms"></a> [io-premium-reminder-ms](#input\_io-premium-reminder-ms) | n/a | `map` | <pre>{<br>  "pipeline": {<br>    "enable_code_review": true,<br>    "enable_deploy": true<br>  },<br>  "repository": {<br>    "branch_name": "refs/heads/master",<br>    "name": "io-premium-reminder-ms",<br>    "organization": "pagopa",<br>    "pipelines_path": ".devops",<br>    "yml_prefix_name": null<br>  }<br>}</pre> | no |
| <a name="input_prod_subscription_name"></a> [prod\_subscription\_name](#input\_prod\_subscription\_name) | PROD Subscription name | `string` | n/a | yes |
| <a name="input_project_name_prefix"></a> [project\_name\_prefix](#input\_project\_name\_prefix) | Project name prefix (e.g. userregistry) | `string` | n/a | yes |
| <a name="input_tlscert-prod-weubeta-messages-internal-io-pagopa-it"></a> [tlscert-prod-weubeta-messages-internal-io-pagopa-it](#input\_tlscert-prod-weubeta-messages-internal-io-pagopa-it) | n/a | `map` | <pre>{<br>  "pipeline": {<br>    "dns_record_name": "weubeta.messages.internal",<br>    "dns_zone_name": "io.pagopa.it",<br>    "enable_tls_cert": true,<br>    "path": "TLS-Certificates\\PROD",<br>    "variables": {<br>      "CERT_NAME_EXPIRE_SECONDS": "2592000"<br>    },<br>    "variables_secret": {}<br>  },<br>  "repository": {<br>    "branch_name": "refs/heads/master",<br>    "name": "le-azure-acme-tiny",<br>    "organization": "pagopa",<br>    "pipelines_path": "."<br>  }<br>}</pre> | no |
| <a name="input_tlscert-prod-weuprod01-messages-internal-io-pagopa-it"></a> [tlscert-prod-weuprod01-messages-internal-io-pagopa-it](#input\_tlscert-prod-weuprod01-messages-internal-io-pagopa-it) | n/a | `map` | <pre>{<br>  "pipeline": {<br>    "dns_record_name": "weuprod01.messages.internal",<br>    "dns_zone_name": "io.pagopa.it",<br>    "enable_tls_cert": true,<br>    "path": "TLS-Certificates\\PROD",<br>    "variables": {<br>      "CERT_NAME_EXPIRE_SECONDS": "2592000"<br>    },<br>    "variables_secret": {}<br>  },<br>  "repository": {<br>    "branch_name": "refs/heads/master",<br>    "name": "le-azure-acme-tiny",<br>    "organization": "pagopa",<br>    "pipelines_path": "."<br>  }<br>}</pre> | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
