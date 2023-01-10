output "project" {
  description = "プロジェクトID"
  value = {
    for project in gitlab_project.project :
      project.id => tostring(project.id)
  }
}

output "random" {
  description = "プロジェクトごとに割り当てるWebhookトークン用ランダム文字列"
  value = {
    for name in random_password.name :
      name.keepers.id => name.result
  }
}