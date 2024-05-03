#
# 🐙 GITHUB
#

# Github service connection (read-only)
resource "azuredevops_serviceendpoint_github" "azure-devops-github-ro" {
  project_id            = azuredevops_project.project.id
  service_endpoint_name = "azure-devops-github-ro-${local.domain}"
  auth_personal {
    personal_access_token = module.secrets_azdo.values["azure-devops-github-ro-TOKEN"].value
  }
  lifecycle {
    ignore_changes = [description, authorization]
  }
}

# Github service connection (read write)
resource "azuredevops_serviceendpoint_github" "azure-devops-github-rw" {
  project_id            = azuredevops_project.project.id
  service_endpoint_name = "azure-devops-github-rw-${local.domain}"
  auth_personal {
    personal_access_token = module.secrets_azdo.values["azure-devops-github-rw-TOKEN"].value
  }
  lifecycle {
    ignore_changes = [description, authorization]
  }
}

# Github service connection (pull request)
resource "azuredevops_serviceendpoint_github" "azure-devops-github-pr" {
  project_id            = azuredevops_project.project.id
  service_endpoint_name = "azure-devops-github-pr-${local.domain}"
  auth_personal {
    personal_access_token = module.secrets_azdo.values["azure-devops-github-pr-TOKEN"].value
  }
  lifecycle {
    ignore_changes = [description, authorization]
  }
}
