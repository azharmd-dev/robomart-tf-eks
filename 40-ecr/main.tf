resource "aws_ecr_repository" "repos" {
  for_each = toset(var.ecr_repositories)

  name                 = "${var.project_name}/${each.value}"
  image_tag_mutability = "MUTABLE"
  force_delete         = true

  image_scanning_configuration {
    scan_on_push = false
  }
}
