# stack-aws-hub-hosted-services

Stack that deploys the app resources to expose AWS hosted Hub services to the hybrid account via an app account

This stack opens up connectivity so that on-prem services can talk to AWS hosted services. This is done via AWS
PrivateLink (https://aws.amazon.com/privatelink).

The stack uses the following modules

* module-aws-helper
* module-aws-nlb
* module-aws-service-provider

The stack deploys the following components:

* In the app account... (Provider)
  * An NLB that sits in front of the application exposing the application from consumption by on-prem services
  * A private link service endpoint

![alt text](img/Hub_hosted_services.png "Digram showing inbound connectivity pattern")

In the app account, it's the responsibility of the autoscaling stack to latch onto the NLB that is created. In the hybrid
account, the right CIDR blocks need to be passed in to whitelist access to the endpoint.

## Usage

This stack is expected to be deployed once - it uses configuration stored within our tfvars group.

It needs to be deployed before its hybrid variant.

Currently these are the four apps that need to be exposed:

* hub-java-application
* hub-java-service
* hub-php-application
* hub-php-framework

It's important to use the right environment name and stack instance name for deploying these stacks. The environment name is
important as it namespaces the backend storage settings and the stack instance to allow for the deployment of multiple instances
of this stack. Further more, the value of "each.key" of the consumer_configuration variable, is used to name resources. Its also
used to lookup parameter store values to find the right service name for each endpoint.
Please note that the names for the target groups and listeners are set in the tfvars file (NOT via the stack instance variable!!).
These need to be updated to ensure there are no clashes between these resources. So if you are using the stack instance "env02",
make sure you have a env02 variant of the tfvar file with different names for these resources. Also dont forget to update the
target group name in the listener block

````
target_groups = {
      "nlb-tg-java-app-env01" : {     <-  #Change env01 to match your stack instance name
        "protocol" : "tcp"
        "port" : 8443
        "target_type" : "instance"
        "health_check_protocol" : "tcp"
        "health_check_enabled" : null
        "health_check_interval" : null
        "health_check_path" : null
        "health_check_port" : null
      }
    }
    listeners = {
      "nlb-lsnr-java-app-env01" : {    <-  #Change env01 to match your stack instance name
        port            = 443
        ssl_policy      = null
        protocol        = "tcp"
        certificate_arn = null
        target_group    = "nlb-tg-java-app-env01"  <-  #Change env01 to match your stack instance name
        forward         = {}
      }
    }
````

Only one profile is required for this stack - the admin role associated with the application account.

Here is an example to deploy the resources into the dev account

````
stack --profile default plan -e dev01 -i env01 -s stack-aws-hub-hosted-services -f ../tfvars/tfvars-dev-account/stack-aws-hub-hosted-services-env01.tfvars
stack --profile default apply -e dev01 -i env01 -s stack-aws-hub-hosted-services -f ../tfvars/tfvars-dev-account/stack-aws-hub-hosted-services-env01.tfvars
stack --profile default destroy -e dev01 -i env01 -s stack-aws-hub-hosted-services -f ../tfvars/tfvars-dev-account/stack-aws-hub-hosted-services-env01.tfvars
````

For other accounts, swap dev01 to test01 and prod01 and pick the appropriate tfvar file.

## Hub specific configuration

The following commands should be used to deploy the inbound private links. The env02 variants show how to deploy other instances for other environments.

````
stack --profile provisioner apply -e dev01 -i env01 -s stack-aws-hub-hosted-services -f ../tfvars/tfvars-dev-account/stack-aws-hub-hosted-services-env01.tfvars
stack --profile provisioner apply -e dev01 -i env02 -s stack-aws-hub-hosted-services -f ../tfvars/tfvars-dev-account/stack-aws-hub-hosted-services-env02.tfvars

stack --profile provisioner apply -e test01 -i env01 -s stack-aws-hub-hosted-services -f ../tfvars/tfvars-test-account/stack-aws-hub-hosted-services-env01.tfvars
stack --profile provisioner apply -e test01 -i env02 -s stack-aws-hub-hosted-services -f ../tfvars/tfvars-test-account/stack-aws-hub-hosted-services-env02.tfvars

stack --profile provisioner apply -e prod01 -i env01 -s stack-aws-hub-hosted-services -f ../tfvars/tfvars-prod-account/stack-aws-hub-hosted-services-env01.tfvars
stack --profile provisioner apply -e prod01 -i env02 -s stack-aws-hub-hosted-services -f ../tfvars/tfvars-prod-account/stack-aws-hub-hosted-services-env02.tfvars

Where provisioner = profile that is mapped against the admin role for the application account being targeted
````
The above deployments result in the following unfriendly domain names in each account. These point to the NLB in the
provider account (application account) and to the endpoint in the consumer account (hybrid account)

Dev + non-prod hybrid
* hub-java-apps.env01.dev01.app15421nh1.robt.euwe2.prd-plat.int.aws.bt.com
* hub-java-services.env01.dev01.app15421nh1.robt.euwe2.prd-plat.int.aws.bt.com
* hub-php-apps.env01.dev01.app15421nh1.robt.euwe2.prd-plat.int.aws.bt.com
* hub.env01.dev01.app15421nh1.robt.euwe2.prd-plat.int.aws.bt.com

Test + Non-prod hybrid
* hub-java-apps.env01.test01.app15421nh1.robt.euwe2.prd-plat.int.aws.bt.com
* hub-java-services.env01.test01.app15421nh1.robt.euwe2.prd-plat.int.aws.bt.com
* hub-php-apps.env01.test01.app15421nh1.robt.euwe2.prd-plat.int.aws.bt.com
* hub.env01.test01.app15421nh1.robt.euwe2.prd-plat.int.aws.bt.com

Prod + prod hybrid
* hub-java-apps.env01.prod01.app15421ph1.robt.euwe2.prd-plat.int.aws.bt.com
* hub-java-services.env01.prod01.app15421ph1.robt.euwe2.prd-plat.int.aws.bt.com
* hub-php-apps.env01.prod01.app15421ph1.robt.euwe2.prd-plat.int.aws.bt.com
* hub.env01.prod01.app15421ph1.robt.euwe2.prd-plat.int.aws.bt.com


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | = 0.14.7 |
| aws | ~> 3.30.0 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 3.30.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| aws-nlb | ../../modules/module-aws-nlb |  |
| helper | ../../modules/module-aws-helper |  |
| hub-provider-endpoint-service | ../../modules/module-aws-service-provider |  |

## Resources

| Name |
|------|
| [aws_caller_identity](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) |
| [aws_route53_record](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) |
| [aws_route53_zone](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) |
| [aws_ssm_parameter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| acceptance\_required | Sets whether acceptance is required for the private link | `bool` | `false` | no |
| access\_logs\_enabled | Enable access logging. | `string` | `true` | no |
| allowed\_principals | n/a | `map(list(string))` | <pre>{<br>  "dev": [<br>    "arn:aws:iam::442159431234:root"<br>  ],<br>  "prod": [<br>    "arn:aws:iam::495683398525:root"<br>  ],<br>  "test": [<br>    "arn:aws:iam::442159431234:root"<br>  ]<br>}</pre> | no |
| aws\_profile | n/a | `any` | n/a | yes |
| aws\_region | n/a | `any` | n/a | yes |
| enable\_cross\_zone\_load\_balancing | If true, cross-zone load balancing of the load balancer will be enabled. | `bool` | `false` | no |
| enable\_deletion\_protection | If true, deletion of the load balancer will be disabled via the AWS API. | `bool` | `false` | no |
| environment\_name | n/a | `any` | n/a | yes |
| nlb\_hosted\_zone | n/a | `string` | `""` | no |
| owner | n/a | `any` | n/a | yes |
| provider\_configuration | Configuration of the provider endpoint + nlb | <pre>map(object({<br>    full_service_name = string<br>    friendly_domain_name : string<br>    target_groups = map(map(string))<br>    listeners = map(object(<br>      {<br>        port            = number<br>        protocol        = string<br>        ssl_policy      = string<br>        certificate_arn = string<br>        target_group    = string<br>        forward = map(object(<br>          {<br>            weight = number<br>            stickiness = object({<br>              enabled  = bool<br>              duration = number<br>            })<br>          }<br>        ))<br>    }))<br>  }))</pre> | <pre>{<br>  "test-application": {<br>    "friendly_domain_name": "hub-test-app",<br>    "full_service_name": "test-app",<br>    "listeners": {<br>      "nlb-lsnr-test-app": {<br>        "certificate_arn": null,<br>        "forward": {},<br>        "port": 80,<br>        "protocol": "tcp",<br>        "ssl_policy": null,<br>        "target_group": "nlb-tg-test-app"<br>      }<br>    },<br>    "target_groups": {<br>      "nlb-tg-test-app": {<br>        "health_check_enabled": null,<br>        "health_check_interval": null,<br>        "health_check_path": null,<br>        "health_check_port": null,<br>        "health_check_protocol": "tcp",<br>        "port": 80,<br>        "protocol": "tcp",<br>        "target_type": "instance"<br>      }<br>    }<br>  }<br>}</pre> | no |
| stack\_instance | n/a | `any` | n/a | yes |
| stack\_name | n/a | `any` | n/a | yes |
| terraform\_version | n/a | `any` | n/a | yes |
| user | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| nlb\_arn | Network load balancer arn |
| nlb\_target\_groups | Network load balancer target groups |
| provider\_route53\_names | Provider route 53 entries |
| provider\_service\_name | Name of VPC Endpoint Service |
| provider\_service\_name\_pmstore\_key | Parameter store key for the name of VPC Endpoint Service |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
