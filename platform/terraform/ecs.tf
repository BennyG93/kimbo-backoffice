# module "ecs" {
#   source  = "terraform-aws-modules/ecs/aws"
#   version = "2.8.0"

#   create_ecs = true
  
#   name               = var.app_name
#   container_insights = true
#   capacity_providers = ["FARGATE"]
# }

## The ECS task definition and service are managed outside of TF
## because they change often with CICD implimentation
## 
# resource "aws_ecs_task_definition" "kimbo_backoffice" {
#   family                = "${var.app_name}-task"
#   container_definitions = file("files/ecs/task-definition.json")

#   task_role_arn            = aws_iam_role.application_role.arn
#   execution_role_arn       = aws_iam_role.application_role.arn
#   network_mode             = "awsvpc"
#   cpu                      = "512"
#   memory                   = "2048"
#   requires_compatibilities = ["FARGATE"]
# }

# resource "aws_ecs_service" "kimbo_backoffice" {
#   name            = "${var.app_name}-svc"
#   cluster         = module.ecs.this_ecs_cluster_id
#   task_definition = aws_ecs_task_definition.kimbo_backoffice.arn
#   launch_type     = "FARGATE"
#   desired_count   = 1

#   health_check_grace_period_seconds = 60
#   enable_ecs_managed_tags           = true

#   load_balancer {
#     target_group_arn = module.alb.target_group_arns[0]
#     container_name   = var.app_name
#     container_port   = 80
#   }

#   network_configuration {
#       subnets         = var.vpc.subnets
#       security_groups = [aws_security_group.external_lb.id]
#   }
# }
