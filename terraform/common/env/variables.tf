variable "gitlab_setting" {
  description = "GitLabのAPIエンドポイントへアクセスするための設定情報"
  type = object({
    baseUrl = string # GitLabのドメイン（最後に"/"は不要）
    api     = string # APIエンドポイントへのルートパス
  })
  default = {
    baseUrl = "http://gitlab-webservice-default.gitlab.svc.cluster.local"
    api     = "/api/v4/"
  }
}

variable "gitlab_token" {
  description = "GITLABアクセストークン（トークンはterraformコマンド実行時のパラメータもしくは環境変数TF_VAR_gitlab_tokenにて設定する）"
  type        = string
}

variable "gitlab_user_common" {
  description = "GitLabユーザー共通設定"
  type = object({
    is_admin         = bool   # 管理者権限
    projects_limit   = number # 参加可能プロジェクト数
    can_create_group = bool   # グループ作成権限
    is_external      = bool   # 権限の付与されていないプロジェクトへのアクセス可否
    reset_password   = bool   # パスワードリセット
    default_password = string
  })
  default = {
    is_admin         = false
    projects_limit   = 5
    can_create_group = false
    is_external      = false
    reset_password   = false #メールを飛ばせる環境であればtrueにする
    default_password = "xxxxxxxxxx" # 任意のパスワードをセットする
  }
}

variable "gitlab_users" {
  description = "GitLab利用ユーザー（複数設定）"
  type = list(object({
    id    = string
    name  = string
    email = string # すべて小文字に置き換えられるので最初から小文字にしておくこと（大文字があると毎回差分になる）
  }))
  default = [
    {
      id    = "ID000001",
      name  = "test1"
      email = "XXXXXXX" # ユーザーのメールアドレス
    },
    {
      id    = "ID000002",
      name  = "test2"
      email = "XXXXXXX" # ユーザーのメールアドレス
    }
  ]
}
