resource "random_password" "master" {
  length = 10
}

module "aurora" {
  source  = "terraform-aws-modules/rds-aurora/aws"
  version = "3.10.0"
  
  create_cluster = true

  name                  = "${var.app_name}-strapi-database"
  engine                = "aurora-mysql"
  engine_version        = "5.7.mysql_aurora.2.07.2"
  instance_type         = "db.t3.small"

  vpc_id                = var.vpc.id
  subnets               = var.vpc.subnets
  create_security_group = true
  allowed_cidr_blocks   = [var.vpc.cidr, "0.0.0.0/0"]
  publicly_accessible   = true

  apply_immediately   = true

  db_parameter_group_name         = aws_db_parameter_group.parameter_group.name
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.cluster_parameter_group.name
}

resource "aws_db_parameter_group" "parameter_group" {
  name        = "${var.app_name}-parameter-group"
  family      = "aurora-mysql5.7"
  description = "${var.app_name}-parameter-group"
}

resource "aws_rds_cluster_parameter_group" "cluster_parameter_group" {
  name        = "${var.app_name}-cluster-parameter-group"
  family      = "aurora-mysql5.7"
  description = "${var.app_name}-cluster-parameter-group"
}