output "users" {
  description = "作成したユーザーを出力（グループ割り当てで使用）"
  value = {
    for user in gitlab_user.users :
    user.username => user.id
  }
}