resource "aws_ecr_repository" "kimbo_backoffice_container_repo" {
  name                 = var.app_name
  image_tag_mutability = "MUTABLE"

#   image_scanning_configuration {
#     scan_on_push = true
#   }
}