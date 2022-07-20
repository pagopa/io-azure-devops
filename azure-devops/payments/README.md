<!-- markdownlint-disable -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Requirements

| Name                                                                           | Version   |
| ------------------------------------------------------------------------------ | --------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform)       | >= 1.1.5  |
| <a name="requirement_azuredevops"></a> [azuredevops](#requirement_azuredevops) | >= 0.2.0  |
| <a name="requirement_azurerm"></a> [azurerm](#requirement_azurerm)             | >= 2.99.0 |

## Providers

| Name                                                                        | Version |
| --------------------------------------------------------------------------- | ------- |
| <a name="provider_azuredevops"></a> [azuredevops](#provider_azuredevops)    | 0.2.1   |
| <a name="provider_azurerm.prod"></a> [azurerm.prod](#provider_azurerm.prod) | 3.4.0   |

## Modules

| Name                                                                                                                                                                                                                       | Source                                                                                                 | Version |
| -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------ | ------- |
| <a name="module_PROD-TLS-CERT-SERVICE-CONN"></a> [PROD-TLS-CERT-SERVICE-CONN](#module_PROD-TLS-CERT-SERVICE-CONN)                                                                                                          | git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_serviceendpoint_azurerm_limited | v2.0.5  |
| <a name="module_letsencrypt_prod"></a> [letsencrypt_prod](#module_letsencrypt_prod)                                                                                                                                        | git::https://github.com/pagopa/azurerm.git//letsencrypt_credential                                     | v2.14.0 |
| <a name="module_secrets_azdo"></a> [secrets_azdo](#module_secrets_azdo)                                                                                                                                                    | git::https://github.com/pagopa/azurerm.git//key_vault_secrets_query                                    | v2.0.5  |
| <a name="module_secrets_prod"></a> [secrets_prod](#module_secrets_prod)                                                                                                                                                    | git::https://github.com/pagopa/azurerm.git//key_vault_secrets_query                                    | v2.0.5  |
| <a name="module_tlscert-prod-weubeta-payments-internal-io-pagopa-it-cert_az"></a> [tlscert-prod-weubeta-payments-internal-io-pagopa-it-cert_az](#module_tlscert-prod-weubeta-payments-internal-io-pagopa-it-cert_az)       | git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_tls_cert       | v2.0.5  |
| <a name="module_tlscert-prod-weuprod01-payments-internal-io-pagopa-it-cert_az"></a> [tlscert-prod-weuprod01-payments-internal-io-pagopa-it-cert_az](#module_tlscert-prod-weuprod01-payments-internal-io-pagopa-it-cert_az) | git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_tls_cert       | v2.0.5  |

## Resources

| Name                                                                                                                                                                          | Type        |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [azuredevops_serviceendpoint_azurecr.acr_docker_registry_prod](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/serviceendpoint_azurecr)   | resource    |
| [azuredevops_serviceendpoint_github.azure-devops-github-pr](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/serviceendpoint_github)       | resource    |
| [azuredevops_serviceendpoint_github.azure-devops-github-ro](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/serviceendpoint_github)       | resource    |
| [azuredevops_serviceendpoint_github.azure-devops-github-rw](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/serviceendpoint_github)       | resource    |
| [azuredevops_serviceendpoint_kubernetes.aks-weu-beta](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/serviceendpoint_kubernetes)         | resource    |
| [azuredevops_serviceendpoint_kubernetes.aks-weu-prod01](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/serviceendpoint_kubernetes)       | resource    |
| [azurerm_key_vault_access_policy.PROD-TLS-CERT-SERVICE-CONN_kv_prod](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource    |
| [azuredevops_project.project](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/data-sources/project)                                                 | data source |
| [azurerm_key_vault.kv_prod](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault)                                                     | data source |

## Inputs

| Name                                                                                                                                                                                             | Description                             | Type     | Default                                                                                                                                                                                                                                                                                                                                                                                                                                                  | Required |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | --------------------------------------- | -------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------: |
| <a name="input_prod_subscription_name"></a> [prod_subscription_name](#input_prod_subscription_name)                                                                                              | PROD Subscription name                  | `string` | n/a                                                                                                                                                                                                                                                                                                                                                                                                                                                      |   yes    |
| <a name="input_project_name_prefix"></a> [project_name_prefix](#input_project_name_prefix)                                                                                                       | Project name prefix (e.g. userregistry) | `string` | n/a                                                                                                                                                                                                                                                                                                                                                                                                                                                      |   yes    |
| <a name="input_tlscert-prod-weubeta-payments-internal-io-pagopa-it"></a> [tlscert-prod-weubeta-payments-internal-io-pagopa-it](#input_tlscert-prod-weubeta-payments-internal-io-pagopa-it)       | n/a                                     | `map`    | <pre>{<br> "pipeline": {<br> "dns_record_name": "weubeta.payments.internal",<br> "dns_zone_name": "io.pagopa.it",<br> "enable_tls_cert": true,<br> "path": "TLS-Certificates\\PROD",<br> "variables": {<br> "CERT_NAME_EXPIRE_SECONDS": "2592000"<br> },<br> "variables_secret": {}<br> },<br> "repository": {<br> "branch_name": "master",<br> "name": "le-azure-acme-tiny",<br> "organization": "pagopa",<br> "pipelines_path": "."<br> }<br>}</pre>   |    no    |
| <a name="input_tlscert-prod-weuprod01-payments-internal-io-pagopa-it"></a> [tlscert-prod-weuprod01-payments-internal-io-pagopa-it](#input_tlscert-prod-weuprod01-payments-internal-io-pagopa-it) | n/a                                     | `map`    | <pre>{<br> "pipeline": {<br> "dns_record_name": "weuprod01.payments.internal",<br> "dns_zone_name": "io.pagopa.it",<br> "enable_tls_cert": true,<br> "path": "TLS-Certificates\\PROD",<br> "variables": {<br> "CERT_NAME_EXPIRE_SECONDS": "2592000"<br> },<br> "variables_secret": {}<br> },<br> "repository": {<br> "branch_name": "master",<br> "name": "le-azure-acme-tiny",<br> "organization": "pagopa",<br> "pipelines_path": "."<br> }<br>}</pre> |    no    |

## Outputs

No outputs.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->