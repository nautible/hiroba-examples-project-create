resource "gitlab_repository_file" "project_gitlab" {
  for_each       = gitlab_project.project
  project        = each.value.id
  file_path      = ".gitlab-ci.yml"
  branch         = "main"
  content        = base64encode("${data.template_file.project_gitlab[each.value.name].rendered}")
  author_email   = "terraform@author.email"
  author_name    = "Terraform"
  commit_message = "feature: add service file"
  lifecycle {
    # コンテンツは初期作成のみ 差分更新しない
    ignore_changes = [content]
  }
}

data "template_file" "project_gitlab" {
  template  = "${file("../modules/gitlab/templates/gitlab-ci.yml.tpl")}"
  for_each  = var.project_setting.projects
  vars = {
    gitlab_token = var.group.token
    gitlab_url   = var.gitlab_setting.baseUrl
    gitlab_api   = var.gitlab_setting.api
    group        = var.group.name
    project      = each.key
    ci_user      = var.group.id
    ecr_uri      = var.ecr_uri
    project_path = urlencode("${var.group.name}/${each.key}")
  }
}
