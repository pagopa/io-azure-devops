<!-- markdownlint-disable -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.5 |
| <a name="requirement_azuredevops"></a> [azuredevops](#requirement\_azuredevops) | <= 0.11.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | <= 3.100.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuredevops"></a> [azuredevops](#provider\_azuredevops) | 0.11.0 |
| <a name="provider_azurerm.prod"></a> [azurerm.prod](#provider\_azurerm.prod) | 3.53.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_PROD-TLS-CERT-SERVICE-CONN"></a> [PROD-TLS-CERT-SERVICE-CONN](#module\_PROD-TLS-CERT-SERVICE-CONN) | git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_serviceendpoint_azurerm_limited | v3.1.1 |
| <a name="module_letsencrypt_prod"></a> [letsencrypt\_prod](#module\_letsencrypt\_prod) | git::https://github.com/pagopa/terraform-azurerm-v3.git//letsencrypt_credential | v6.20.0 |
| <a name="module_secrets_azdo"></a> [secrets\_azdo](#module\_secrets\_azdo) | git::https://github.com/pagopa/terraform-azurerm-v3.git//key_vault_secrets_query | v6.20.0 |
| <a name="module_secrets_prod"></a> [secrets\_prod](#module\_secrets\_prod) | git::https://github.com/pagopa/terraform-azurerm-v3.git//key_vault_secrets_query | v6.20.0 |
| <a name="module_tlscert-openid-provider-io-pagopa-it-cert_az"></a> [tlscert-openid-provider-io-pagopa-it-cert\_az](#module\_tlscert-openid-provider-io-pagopa-it-cert\_az) | github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_tls_cert_federated | v4.2.2 |
| <a name="module_tlscert-prod-firmaconio-selfcare-pagopa-it-cert_az"></a> [tlscert-prod-firmaconio-selfcare-pagopa-it-cert\_az](#module\_tlscert-prod-firmaconio-selfcare-pagopa-it-cert\_az) | git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_tls_cert | v3.1.1 |
| <a name="module_tlscert-prod-selfcare-io-pagopa-it-cert_az"></a> [tlscert-prod-selfcare-io-pagopa-it-cert\_az](#module\_tlscert-prod-selfcare-io-pagopa-it-cert\_az) | git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_tls_cert | v3.1.1 |

## Resources

| Name | Type |
|------|------|
| [azuredevops_serviceendpoint_github.azure-devops-github-pr](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/serviceendpoint_github) | resource |
| [azuredevops_serviceendpoint_github.azure-devops-github-ro](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/serviceendpoint_github) | resource |
| [azuredevops_serviceendpoint_github.azure-devops-github-rw](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/serviceendpoint_github) | resource |
| [azurerm_key_vault_access_policy.PROD-TLS-CERT-SERVICE-CONN_kv_prod](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azuredevops_project.project](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/data-sources/project) | data source |
| [azurerm_key_vault.kv_prod](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_prod_subscription_name"></a> [prod\_subscription\_name](#input\_prod\_subscription\_name) | PROD Subscription name | `string` | n/a | yes |
| <a name="input_project_name_prefix"></a> [project\_name\_prefix](#input\_project\_name\_prefix) | Project name prefix (e.g. userregistry) | `string` | n/a | yes |
| <a name="input_tlscert-openid-provider-io-pagopa-it"></a> [tlscert-openid-provider-io-pagopa-it](#input\_tlscert-openid-provider-io-pagopa-it) | n/a | `map` | <pre>{<br>  "pipeline": {<br>    "dns_record_name": "openid-provider",<br>    "dns_zone_name": "io.pagopa.it",<br>    "dns_zone_resource_group": "io-p-rg-external",<br>    "enable_tls_cert": true,<br>    "path": "TLS-Certificates\\PROD",<br>    "variables": {<br>      "CERT_NAME_EXPIRE_SECONDS": "2592000",<br>      "KEY_VAULT_NAME": "io-p-kv",<br>      "RESOURCE_GROUP_NAME": "io-p-sec-rg"<br>    },<br>    "variables_secret": {}<br>  },<br>  "repository": {<br>    "branch_name": "refs/heads/master",<br>    "name": "le-azure-acme-tiny",<br>    "organization": "pagopa",<br>    "pipelines_path": "."<br>  }<br>}</pre> | no |
| <a name="input_tlscert-prod-firmaconio-selfcare-pagopa-it"></a> [tlscert-prod-firmaconio-selfcare-pagopa-it](#input\_tlscert-prod-firmaconio-selfcare-pagopa-it) | n/a | `map` | <pre>{<br>  "pipeline": {<br>    "dns_record_name": "",<br>    "dns_zone_name": "firmaconio.selfcare.pagopa.it",<br>    "enable_tls_cert": true,<br>    "path": "TLS-Certificates\\PROD",<br>    "variables": {<br>      "CERT_NAME_EXPIRE_SECONDS": "2592000"<br>    },<br>    "variables_secret": {}<br>  },<br>  "repository": {<br>    "branch_name": "refs/heads/master",<br>    "name": "le-azure-acme-tiny",<br>    "organization": "pagopa",<br>    "pipelines_path": "."<br>  }<br>}</pre> | no |
| <a name="input_tlscert-prod-selfcare-io-pagopa-it"></a> [tlscert-prod-selfcare-io-pagopa-it](#input\_tlscert-prod-selfcare-io-pagopa-it) | n/a | `map` | <pre>{<br>  "pipeline": {<br>    "dns_record_name": "selfcare",<br>    "dns_zone_name": "io.pagopa.it",<br>    "enable_tls_cert": true,<br>    "path": "TLS-Certificates\\PROD",<br>    "variables": {<br>      "CERT_NAME_EXPIRE_SECONDS": "2592000"<br>    },<br>    "variables_secret": {}<br>  },<br>  "repository": {<br>    "branch_name": "refs/heads/master",<br>    "name": "le-azure-acme-tiny",<br>    "organization": "pagopa",<br>    "pipelines_path": "."<br>  }<br>}</pre> | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
