# Configure the AWS Provider
provider "aws" {
  region  = "eu-west-1"
}

# Configure the Digital Ocean Provider
provider "digitalocean" {
  token = local.app_secrets["DO_API_KEY"]
}
