/* Variables for ECR Module */
variable "user" {}
variable "owner" {}
variable "stack_name" {}
variable "environment_name" {}
variable "stack_instance" {} 

variable "terraform_version" {
  type        = string
  description = "Terraform version to be used"
}

variable "aws_region" {
  type        = string
  default     = "eu-west-2"
  description = "AWS Region"
}
variable "aws_profile" {
  type        = string
  default     = "bill-admin"
  description = "AWS Profile"
}

variable "repo_name" {
  type = list(string)
  default = [
    "letter-service"
  ]
}


variable "allowed_principals" {
  type        = list(string)
  description = "Allowed Principals for ECR Repository Policy"
  default = [
    "arn:aws:iam::642343408111:root",
    "arn:aws:iam::537126451601:root"
  ]
}
