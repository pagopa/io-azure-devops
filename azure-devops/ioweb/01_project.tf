resource "azuredevops_project" "project" {
  name               = "${local.domain}-projects"
  description        = "This is the DevOps project for ${local.domain} projects"
  visibility         = "public"
  version_control    = "Git"
  work_item_template = "Basic"
}
