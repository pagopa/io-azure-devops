data "azuredevops_project" "project" {
  name = "${var.project_name_prefix}-projects"
}
