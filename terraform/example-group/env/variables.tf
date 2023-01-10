variable "gitlab_setting" {
  description = "GitLabのAPIエンドポイントへアクセスするための設定情報"
  type = object({
    baseUrl = string # GitLabのドメイン（最後に"/"は不要）
    api     = string # APIエンドポイントへのルートパス
  })
  default   = {
    baseUrl = "http://gitlab-webservice-default.gitlab.svc.cluster.local"
    api     = "/api/v4/"
  }
}

variable "gitlab_token" {
  description = "GITLABアクセストークン（terraformコマンド実行時のパラメータもしくは環境変数TF_VAR_gitlab_tokenにて設定する）"
  type = string
}

variable "http_proxy" {
  description = "HTTP_PROXY（terraformコマンド実行時のパラメータもしくは環境変数TF_VAR_http_proxyにて設定する）"
  type = string
}

variable "https_proxy" {
  description = "HTTPS_PROXY（terraformコマンド実行時のパラメータもしくは環境変数TF_VAR_https_proxyにて設定する）"
  type = string
}

variable "no_proxy" {
  description = "NO_PROXY（terraformコマンド実行時のパラメータもしくは環境変数TF_VAR_no_proxyにて設定する）"
  type = string
}

variable "access_key" {
  description = "AWSアクセス用アクセスキー（terraformコマンド実行時のパラメータもしくは環境変数TF_VAR_access_keyにて設定する）"
  type = string
}

variable "secret_key" {
  description = "AWSアクセス用シークレットキー（terraformコマンド実行時のパラメータもしくは環境変数TF_VAR_secret_keyにて設定する）"
  type = string
}

variable "ecr_uri" {
  description = "ECRエンドポイントドメイン（terraformコマンド実行時のパラメータもしくは環境変数TF_VAR_ecr_uriにて設定する）"
  type = string
}

variable "project_setting" {
  default = {
    name  = "demo1"
    path  = "demo1"
    description  = "demo1 group create test"
    users = [
      "ID000001"
    ]
    projects = {
      demo1pj1 = {
        description  = "demo1 group project1"
      }
      demo1pj2 = {
        description  = "demo1 group project2"
      }
    }
  }
}

variable "ecr" {
  default = {
    image_tag_mutability   = "MUTABLE"
    scan_on_push           = false
    encryption_type        = "KMS"
    lifecycle_policy_untag = {
      countNumber          = 3
    }
    lifecycle_policy_tag     = {
      countNumber          = 10
    }
  }
}