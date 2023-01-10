resource "aws_ecr_repository" "ecr_getting-started" {
  for_each  = var.project_setting.projects
  name                 = "${var.project_setting.name}/${each.key}"
  image_tag_mutability = var.ecr.image_tag_mutability

  image_scanning_configuration {
    scan_on_push = var.ecr.scan_on_push
  }
}