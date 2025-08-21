/*output "alb_arn" {
  description = "Network load balancer arn"
  value = tomap({
    for k, alb in module.aws-alb : k => alb.alb_arn
  })
}*/

output "alb_target_groups" {
  description = "Network load balancer target groups"
  value = tomap({
    for k, alb in module.aws-tg : k => alb.alb_target_groups
  })
  sensitive = true
}