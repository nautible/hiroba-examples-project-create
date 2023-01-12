terraform {
  required_providers {
    # gitlabはグループがhashicorpではないので省略できない
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "~>15.7.1"
    }
  }
}

resource "gitlab_user" "users" {
  for_each = var.users

  name             = var.users[each.key].name
  username         = each.key
  password         = var.default_password
  email            = var.users[each.key].email
  is_admin         = var.is_admin
  projects_limit   = var.projects_limit
  can_create_group = var.can_create_group
  is_external      = var.is_external
  reset_password   = var.reset_password

  lifecycle {
    ignore_changes = [name,password,email]
  }
}