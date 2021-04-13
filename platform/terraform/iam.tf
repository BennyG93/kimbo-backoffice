############
# IAM User #
############
resource "aws_iam_user" "application_user" {
  name = var.app_name
  path = "/"
}

############
# IAM Role #
############
resource "aws_iam_role" "application_role" {
  name = var.app_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
    ]
  })
}

###############
# Attachments #
###############
resource "aws_iam_policy_attachment" "secrets_policy" {
  name       = "secrets_policy"
  users      = [aws_iam_user.application_user.name]
  roles      = [aws_iam_role.application_role.name]
  policy_arn = aws_iam_policy.secrets_policy.arn
}

resource "aws_iam_policy_attachment" "bucket_policy" {
  name       = "bucket_policy"
  users      = [aws_iam_user.application_user.name]
  roles      = [aws_iam_role.application_role.name]
  policy_arn = aws_iam_policy.bucket_policy.arn
}

resource "aws_iam_policy_attachment" "ECSTaskExecution" {
  name       = "ECSTaskExecution"
  roles      = [aws_iam_role.application_role.name, "ecsTaskExecutionRole"]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# resource "aws_iam_policy_attachment" "ECSService" {
#   name       = "ECSService"
#   roles      = [aws_iam_role.application_role.name]
#   policy_arn = "arn:aws:iam::aws:policy/aws-service-role/AmazonECSServiceRolePolicy"
# }

############
# Policies #
############
resource "aws_iam_policy" "secrets_policy" {
  name = "${var.app_name}-secrets-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = [
          "secretsmanager:GetResourcePolicy",
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret",
          "secretsmanager:ListSecretVersionIds"
        ],
        Effect   = "Allow"
        Resource = "arn:aws:secretsmanager:eu-west-1:522796919834:secret:*"
      },
      {
        Action   = [
          "secretsmanager:GetRandomPassword",
          "secretsmanager:ListSecrets"
        ],
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_policy" "bucket_policy" {
  name = "${var.app_name}-bucket-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = [
          "s3:DeleteObject",
          "s3:DeleteObjectTagging",
          "s3:DeleteObjectVersion",
          "s3:GetBucketAcl",
          "s3:GetObject",
          "s3:GetObjectAcl",
          "s3:GetObjectTagging",
          "s3:ListBucket",
          "s3:PutObject",
          "s3:PutObjectAcl"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:s3:::kimbo-backoffice/*"
      },
    ]
  })
}
