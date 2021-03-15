#This resource must first be created with local state, and then migrated to S3 after initial creation
resource "aws_s3_bucket" "tfstate-storage-bucket" {
  bucket = "kimbo-terraform-state"

  policy = file("./policies/s3_terraform_policy.json")

  tags = {
    Name        = "kimbo-terraform-state"
    Description = "S3 bucket to store terrafrom state"
    Environment = "all"
    Role        = "infra"
  }

  versioning {
    enabled = true
  }
}
