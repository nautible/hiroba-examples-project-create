output "group" {
  description = "作成したGitLab groupを出力（グループ割り当てで使用）"
  value = {
    name  = gitlab_group.group.name
    id    = gitlab_group.group.id
    token = gitlab_group_access_token.ci_user_token.token
  }
}
