# Use a shared backend - commented out because we don't have one for this exercise
# terraform {
#   backend "s3" {
#     bucket         = "s3prdterraformbackend01"
#     key            = "aws/prod-ci-access/terraform.tfstate"
#     dynamodb_table = "ddbprdterraformbackend01"
#     region         = "us-east-1"
#     profile        = "default"
#   }
# }

# Require the AWS provider
provider "aws" {
  region  = "us-east-1"
  profile = "default"
}

# Load the custom module with the requested resources 
module "prod-ci-access" {
  source    = "./modules/prod-ci-access"
}