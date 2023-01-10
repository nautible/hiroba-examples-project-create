resource "gitlab_repository_file" "base_deployment" {
  for_each       = gitlab_project.project
  project        = each.value.id
  file_path      = "manifests/deployment.yaml"
  branch         = "main"
  content        = base64encode("${data.template_file.base_deployment[each.value.name].rendered}")
  author_email   = "terraform@author.email"
  author_name    = "Terraform"
  commit_message = "feature: add deployment file"
  lifecycle {
    # コンテンツは初期作成のみ 差分更新しない
    ignore_changes = [content]
  }
}

resource "gitlab_repository_file" "base_service" {
  for_each       = gitlab_project.project
  project        = each.value.id
  file_path      = "manifests/service.yaml"
  branch         = "main"
  content        = base64encode("${data.template_file.base_service[each.value.name].rendered}")
  author_email   = "terraform@author.email"
  author_name    = "Terraform"
  commit_message = "feature: add service file"
  lifecycle {
    # コンテンツは初期作成のみ 差分更新しない
    ignore_changes = [content]
  }
}

resource "gitlab_repository_file" "base_kustomization" {
  for_each       = gitlab_project.project
  project        = each.value.id
  file_path      = "manifests/kustomization.yaml"
  branch         = "main"
  content        = base64encode("${data.template_file.base_kustomization[each.value.name].rendered}")
  author_email   = "terraform@author.email"
  author_name    = "Terraform"
  commit_message = "feature: add service file"
  lifecycle {
    # コンテンツは初期作成のみ 差分更新しない
    ignore_changes = [content]
  }
}

data "template_file" "base_deployment" {
  template = "${file("../modules/gitlab/templates/manifests/deployment.yaml.tpl")}"
  for_each     = var.project_setting.projects
  vars = {
    project_name = each.key
    namespace    = var.group.name
    image = "${var.ecr_uri}/${var.group.name}/${each.key}:latest"
  }
}

data "template_file" "base_service" {
  template = "${file("../modules/gitlab/templates/manifests/service.yaml.tpl")}"
  for_each     = var.project_setting.projects
  vars = {
    project_name = each.key
    namespace    = var.group.name
  }
}

data "template_file" "base_kustomization" {
  template = "${file("../modules/gitlab/templates/manifests/kustomization.yaml.tpl")}"
  for_each     = var.project_setting.projects
  vars = {
    project_name = each.key
  }
}
