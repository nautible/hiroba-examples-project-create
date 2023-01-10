provider "gitlab" {
  token = var.gitlab_token
  base_url = "${var.gitlab_setting.baseUrl}${var.gitlab_setting.api}"
  insecure = false
}

terraform {
  # gitlabはグループがhashicorpではないので省略できない
  required_providers {
    gitlab = {
      source = "gitlabhq/gitlab"
      version = "~>15.7.1"
    }
  }
}

# GitLab グループ
module "gitlab_group" {
  source           = "./modules/gitlab/group"
  http_proxy       = var.http_proxy
  https_proxy      = var.https_proxy
  no_proxy         = var.no_proxy
  access_key       = var.access_key
  secret_key       = var.secret_key
  ecr_uri          = var.ecr_uri
  project_setting  = var.project_setting
  providers = {
    gitlab = gitlab
  }
}

# GitLab プロジェクト
module "gitlab_project" {
  source          = "./modules/gitlab/project"
  gitlab_setting  = var.gitlab_setting
  project_setting = var.project_setting
  group           = module.gitlab_group.group
  ecr_uri         = var.ecr_uri

  providers = {
    gitlab = gitlab
  }

  depends_on = [module.gitlab_group]
}

# GitLab ユーザーをグループに参加
module "gitlab_group_membership" {
  source          = "./modules/gitlab/group_membership"
  group           = module.gitlab_group.group
  project_setting = var.project_setting
  users           = var.gitlab_users

  providers = {
    gitlab = gitlab
  }

  depends_on = [module.gitlab_group]
}

module "ecr" {
  source          = "./modules/ecr"
  project_setting = var.project_setting
  ecr             = var.ecr
}

module "kubernetes" {
  source          = "./modules/kubernetes"
  project_setting = var.project_setting
}
