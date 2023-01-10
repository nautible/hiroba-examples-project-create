module "main" {
  source             = "../"
  gitlab_setting     = var.gitlab_setting
  gitlab_token       = var.gitlab_token
  gitlab_user_common = var.gitlab_user_common
  gitlab_users       = var.gitlab_users
}
