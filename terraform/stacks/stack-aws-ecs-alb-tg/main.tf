provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

data "aws_caller_identity" "current" {}

module "aws_helper" {
  source = "../../modules/module-aws-helper"

  region            = var.aws_region
  owner             = var.owner
  user              = var.user
  stack_name        = var.stack_name
  stack_instance    = var.stack_instance
  environment_name  = var.environment_name
  terraform_version = var.terraform_version
}