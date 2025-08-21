module "aws_helper" {
  source            = "../../modules/module-aws-helper"
  owner             = var.owner
  user              = var.user
  terraform_version = var.terraform_version
  stack_name        = var.stack_name
  environment_name  = var.environment_name
  stack_instance    = var.stack_instance

}

data "aws_availability_zones" "available_zones" {
  state = "available"
}

data "aws_caller_identity" "current" {}