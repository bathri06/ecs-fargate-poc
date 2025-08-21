module "aws-alb" {
  source = "../../modules/module-aws-ecs-alb"

  for_each                         = var.provider_configuration
  aws_region                       = var.aws_region
  environment_name                 = var.environment_name
  stack_instance                   = var.stack_instance
  app_id                           = module.aws_helper.application_id
  #vpc_id                           = module.aws_helper.vpc_id
  name                             = format("alb-%s-%s-%s", var.stack_instance, var.environment_name, each.key)
  internal                         = true
  subnets                          = module.aws_helper.private_subnet_list
  alb_security_groups              = [module.hub_container_app_alb_security_group.security_group_id]
  enable_deletion_protection       = var.enable_deletion_protection
  enable_cross_zone_load_balancing = var.enable_cross_zone_load_balancing
  access_logs = {
    bucket  = module.aws_helper.common_bucket_name
    prefix  = "${var.aws_region}/Provider/${var.environment_name}/${each.key}"
    enabled = var.access_logs_enabled
  }
  #target_groups = each.value.target_groups
  listeners     = each.value.listeners
  #listener_rule_forward =  each.value.listener_rule_forward

  tags = merge(
    module.aws_helper.tags,
    { "Name" : format("alb-%s-%s-%s", var.stack_instance, var.environment_name, each.key) }
  )

  depends_on = [ 
    module.hub_container_app_alb_security_group,
    module.hub_container_app_alb_security_group_rules_3000_trafic_egress,
    module.hub_container_app_alb_security_group_rules_443_trafic_ingress,
    module.hub_container_app_alb_security_group_rules_443_trafic_egress
   ]
}