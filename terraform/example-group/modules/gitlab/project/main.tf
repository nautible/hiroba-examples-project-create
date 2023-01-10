terraform {
  required_providers {
    # gitlabはグループがhashicorpではないので省略できない
    gitlab = {
      source = "gitlabhq/gitlab"
      version = "~>15.7.1"
    }
  }
}

resource "gitlab_project" "project" {
  for_each     = var.project_setting.projects
  name         = each.key
  description  = each.value.description
  namespace_id = var.group.id
}

resource "random_password" "name" {
  for_each = gitlab_project.project
  keepers = {
    id = each.value.id
  }
  length  = 16
  upper   = true
  lower   = true
  special = false
}
