resource "kubernetes_manifest" "application" {
  for_each = var.project_setting.projects
  manifest = {
    "apiVersion" = "argoproj.io/v1alpha1"
    "kind"       = "Application"
    "metadata" = {
      "name"      = "${each.key}"
      "namespace" = "argocd"
    }
    "spec" = {
      "destination" = {
        "server" = "https://kubernetes.default.svc"
        "namespace" = "${var.project_setting.name}"
      }
      "project" = "default"
      "source" = {
        "repoURL" = "http://gitlab-webservice-default.gitlab.svc.cluster.local:8181/${var.project_setting.name}/${each.key}"
        "targetRevision" = "HEAD"
        "path" = "manifests/"
      }
      "syncPolicy" = {
        "automated" = {
          "prune" = true
        }
        "syncOptions" = [
          "CreateNamespace=true"
        ]
      }
    }
  }
}
