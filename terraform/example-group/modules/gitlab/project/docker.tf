resource "gitlab_repository_file" "project_dockerfile" {
  for_each       = gitlab_project.project
  project        = each.value.id
  file_path      = "Dockerfile"
  branch         = "main"
  content        = base64encode("${data.template_file.project_dockerfile[each.value.name].rendered}")
  author_email   = "terraform@author.email"
  author_name    = "Terraform"
  commit_message = "feature: add service file"
  lifecycle {
    # コンテンツは初期作成のみ 差分更新しない
    ignore_changes = [content]
  }
}

data "template_file" "project_dockerfile" {
  template = "${file("../modules/gitlab/templates/Dockerfile.tpl")}"
  for_each     = var.project_setting.projects
}
