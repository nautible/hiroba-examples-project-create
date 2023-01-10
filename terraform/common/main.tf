provider "gitlab" {
  token    = var.gitlab_token
  base_url = "${var.gitlab_setting.baseUrl}${var.gitlab_setting.api}"
  insecure = false
}

terraform {
  required_providers {
    # gitlabはグループがhashicorpではないので省略できない
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "~>15.7.1"
    }
  }
}

# GitLabユーザー
module "gitlab_users" {
  source           = "./modules/user"
  is_admin         = var.gitlab_user_common.is_admin
  projects_limit   = var.gitlab_user_common.projects_limit
  can_create_group = var.gitlab_user_common.can_create_group
  is_external      = var.gitlab_user_common.is_external
  reset_password   = var.gitlab_user_common.reset_password
  default_password = var.gitlab_user_common.default_password
  users            = var.gitlab_users

  providers = {
    gitlab = gitlab
  }
}
