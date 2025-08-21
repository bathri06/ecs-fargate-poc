variable "aws_profile" {}
variable "aws_region" {}
variable "environment_name" {}
variable "owner" {}
variable "terraform_version" {}
variable "user" {}
variable "stack_name" {}
variable "stack_instance" {}

variable "provider_configuration" {
  type = map(object({
    target_groups = map(map(string))
    listener_rule_forward = map(object(
      {
        listener_arn = string
        #priority = number
        target_group = string
        path_values = list(string)
        host_header_values= list(string)
        forward = map(object(
          {
            
          }
      ))
    }))
  }))
  description = "Configuration of the provider endpoint + alb"

  default = {
    "test-application" : {
      target_groups = {
        "alb-tg-test-app" : {
          "protocol" : "http"
          "port" : 80
          "target_type" : "ipv4"
          "health_check_protocol" : "http"
          "health_check_enabled" : null
          "health_check_interval" : null
          "health_check_path" : null
          "health_check_port" : null
        }
      }
      listener_rule_forward = {
        "alb-lsnr-rule-test-app" : {
          listener_arn = "alb-tg-test-app"
          #priority = 1
          target_group = "alb-tg-test-app"
          path_values = [ "/test" ]
          host_header_values = ["test.com"]
          forward = {}
        } 
      }
   },
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