#################
# Load balancer #
#################
module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "5.12.0"

  name = var.app_name

  load_balancer_type = "application"

  vpc_id             = var.vpc.id
  subnets            = var.vpc.subnets
  security_groups    = [aws_security_group.external_lb.id]

  access_logs = {
    bucket = module.s3_bucket.this_s3_bucket_id
    prefix  = var.loadbalancer_config.access_logs_prefix
    enabled = true
  }

  target_groups = [
    {
      name             = var.app_name
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "ip"
    }
  ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]
}

##################
# Security group #
##################
resource "aws_security_group" "external_lb" {
  name        = "${var.app_name}-external-lb"
  description = "Allow public inbound traffic"
  vpc_id      = var.vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "https_rule" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.external_lb.id
}

resource "aws_security_group_rule" "http_rule" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.external_lb.id
}
