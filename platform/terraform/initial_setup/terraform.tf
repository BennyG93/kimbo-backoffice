# Make sure the s3 bucket and dynamodb table are created first
terraform {
  backend "s3" {
    bucket         = "kimbo-terraform-state"
    dynamodb_table = "kimbo-terraform-state-lock"
    key            = "infra/initial_setup/terraform.tfstate"
  }
}
