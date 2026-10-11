provider "aws" {
  region = "eu-west-1"

  default_tags {
    tags = {
      Project   = "example-voting-app"
      ManagedBy = "Terraform"
    }
  }
}
