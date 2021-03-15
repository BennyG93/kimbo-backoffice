# This resource must first be created with local state, and then migrated to S3 after initial creation
# create a dynamodb table for locking the state file
resource "aws_dynamodb_table" "terraform_state_lock_table" {
  name         = "kimbo-terraform-state-lock"
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "kimbo-terraform-state-lock"
    Description = "DynamoDB Terraform State Lock Table"
  }
}
