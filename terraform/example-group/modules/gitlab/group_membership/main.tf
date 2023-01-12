terraform {
  required_providers {
    # gitlabはグループがhashicorpではないので省略できない
    gitlab = {
      source = "gitlabhq/gitlab"
      version = "~>15.7.1"
    }
  }
}

resource "gitlab_group_membership" "group_member" {
  for_each = toset(var.project_setting.users)

  group_id     = var.group.id
  user_id      = var.users[each.key]
  access_level = "developer" # guest,reporter,developer,maintainer,owner
}
