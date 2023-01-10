provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "minikube"
}

terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "~>2.16.1"
    }
  }
}

module "main" {
  source          = "../"
  http_proxy        = var.http_proxy
  https_proxy       = var.https_proxy
  no_proxy          = var.no_proxy
  ecr_uri           = var.ecr_uri
  gitlab_setting    = var.gitlab_setting
  gitlab_token      = var.gitlab_token
  project_setting   = var.project_setting
  gitlab_users      = data.terraform_remote_state.common.outputs.users
  access_key        = var.access_key
  secret_key        = var.secret_key
  ecr               = var.ecr
}

data "terraform_remote_state" "common" {
  backend = "local"

  config = {
    path = "../../common/env/terraform.tfstate"
  }
}