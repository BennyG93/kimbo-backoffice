module "s3_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "1.20.0"

  bucket = var.app_name
  acl    = "private"
  
  attach_policy = true
  policy        = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "s3:PutObject",
        Effect    = "Allow"
        Resource  = "arn:aws:s3:::${local.lb_access_logs_path}/*"
        Principal = {
          AWS = "arn:aws:iam::156460612806:root"
        },
      },
      {
        Action    = "s3:PutObject",
        Effect    = "Allow"
        Resource  = "arn:aws:s3:::${local.lb_access_logs_path}/*"
        Principal = {
          Service = "delivery.logs.amazonaws.com"
        },
        Condition = {
          StringEquals = {
            "s3:x-amz-acl" = "bucket-owner-full-control"
          }
        }
      },
      {
        Action    = "s3:GetBucketAcl",
        Effect    = "Allow"
        Resource  = "arn:aws:s3:::${var.app_name}"
        Principal = {
          Service = "delivery.logs.amazonaws.com"
        }
      }
    ]
  })

  versioning = {
    enabled = false
  }

}
