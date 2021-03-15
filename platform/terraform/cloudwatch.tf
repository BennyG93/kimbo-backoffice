resource "aws_cloudwatch_log_group" "kimbo-backoffice-ecs-loggroup" {
  name = "/ecs/${var.app_name}"
}