/* Module ECR */
module "ecr" {
  source            = "../../modules/module-aws-ecr"
  for_each          = toset(var.repo_name)
  repo_name         = "ecr-${var.environment_name}-${var.stack_instance}-${each.value}-repo"
  tags              = module.aws_helper.tags
  repository_policy = data.aws_iam_policy_document.repository_policy.json
}