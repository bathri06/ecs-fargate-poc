variable "aws_profile" {}
variable "aws_region" {}
variable "environment_name" {}
variable "owner" {}
variable "terraform_version" {}
variable "user" {}
variable "stack_name" {}
variable "stack_instance" {}
#variable "alb_name" {}

variable "provider_configuration" {
  type = map(object({
    listeners = map(object(
      {
        port            = number
        protocol        = string
        ssl_policy      = string
        certificate_arn = string
    }))
  }))
  description = "Configuration of the provider endpoint + alb"

  default = {
    "test-application" : {
      listeners = {
        "alb-lsnr-test-app" : {
          port            = 80
          protocol        = "tcp"
          ssl_policy      = null
          certificate_arn = null
        }
      }
   }
  }
} 
variable "acceptance_required" {
  type        = bool
  default     = false
  description = "Sets whether acceptance is required for the private link"
}

variable "enable_deletion_protection" {
  type        = bool
  default     = false
  description = "If true, deletion of the load balancer will be disabled via the AWS API."
}

variable "enable_cross_zone_load_balancing" {
  type        = bool
  default     = false
  description = "If true, cross-zone load balancing of the load balancer will be enabled."
}

variable "access_logs_enabled" {
  type        = string
  default     = true
  description = "Enable access logging."
}

variable "allowed_principals" {
  type = map(list(string))
  default = {
    dev  = ["arn:aws:iam::442159431234:root"]
    test = ["arn:aws:iam::442159431234:root"]
    prod = ["arn:aws:iam::495683398525:root"]
  }
}

variable "alb_hosted_zone" {
  type    = string
  default = ""
}