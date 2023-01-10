terraform {
  required_providers {
    # gitlabはグループがhashicorpではないので省略できない
    gitlab = {
      source = "gitlabhq/gitlab"
      version = "~>15.7.1"
    }
  }
}

# GitLab group の作成
resource "gitlab_group" "group" {
  name        = var.project_setting.name
  path        = var.project_setting.path
  description = var.project_setting.description
  visibility_level = "private"
}

# グループに設定する環境変数

resource "gitlab_group_variable" "access_key" {
  group    = gitlab_group.group.id
  key      = "AWS_ACCESS_KEY_ID"
  value    = var.access_key
}

resource "gitlab_group_variable" "secret_key" {
  group    = gitlab_group.group.id
  key      = "AWS_SECRET_ACCESS_KEY"
  value    = var.secret_key
}

resource "gitlab_group_variable" "ecr_uri" {
  group    = gitlab_group.group.id
  key      = "ECR_URI"
  value    = "${var.ecr_uri}"
}

resource "gitlab_group_variable" "http_proxy" {
  group    = gitlab_group.group.id
  key      = "HTTP_PROXY"
  value    = var.http_proxy
}

resource "gitlab_group_variable" "https_proxy" {
  group    = gitlab_group.group.id
  key      = "HTTPS_PROXY"
  value    = var.https_proxy
}

resource "gitlab_group_variable" "no_proxy" {
  group    = gitlab_group.group.id
  key      = "NO_PROXY"
  value    = var.no_proxy
}

resource "gitlab_group_access_token" "ci_user_token" {
  group        = gitlab_group.group.id
  name         = gitlab_group.group.name
  expires_at   = "2049-12-31"
  access_level = "developer"

  scopes = ["api","write_repository"]
}

resource "gitlab_group_variable" "ci_user_variable" {
  group    = gitlab_group.group.id
  key      = "PAT"
  value    = gitlab_group_access_token.ci_user_token.token
}
