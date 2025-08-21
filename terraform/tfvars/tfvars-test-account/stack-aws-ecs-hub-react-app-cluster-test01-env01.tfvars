#ecs cluster
ecs_cluster_name = "hub-react-app"
container_insights = "enabled"
app ="react"

# API specific vars
api = {
  "customer-selection-app" = {
    name                       = "customer-selection-app"
    port                       = "3000"
    repo_name                  = "ecr-test01-env01-customer-select-app-repo"
    target_group_arn           = "arn:aws:elasticloadbalancing:eu-west-2:775754714306:targetgroup/alb-tg-customer-select-app-env01/2ca96ae1fc0af73e"
    app_port                   = 3000
    app_name                   = "customer-selection"
    base_url                   = "/react-app/customer-selection"
    mem_reservation            = 1024
    hard_limit_cpu             = 512
    hard_limit_mem             = 1024
    desired_count              = 0
    min_tasks                  = 1
    max_tasks                  = 2
    sourceVolume               = "my-vol"
    containerPath              = "/logs"
  },
  "assisted-merge-app" = {
    name                       = "assisted-merge-app"
    port                       = "3000"
    repo_name                  = "ecr-test01-env01-assisted-merge-app-repo"
    target_group_arn           = "arn:aws:elasticloadbalancing:eu-west-2:775754714306:targetgroup/alb-tg-assisted-merge-app-env01/82b2dba8becdcf08"
    app_port                   = 3000
    app_name                   = "assisted-merge"
    base_url                   = "/react-app/assisted-merge"
    mem_reservation            = 1024
    hard_limit_cpu             = 512
    hard_limit_mem             = 1024
    desired_count              = 0
    min_tasks                  = 1
    max_tasks                  = 2
    sourceVolume               = "my-vol"
    containerPath              = "/logs"
  }
}
# iam roles for ecs stack 
iam_roles = [
  "ecs-service",
  "ecs-task-execution",
  "ecs-autoscale"
]
container_essential    = true
port_mapping_protocol  = "tcp"
docker_networking_mode = "awsvpc"
containers_log_driver  = "awslogs"
launch_type            = "FARGATE"

alarm_memory_threshold_bytes = 600000000 #600MB  units in bytes
alarm_cpu_threshold_percent = 75
ok_actions    = [ ]
alarm_actions = [ ]

scheduled_min_tasks        = 0
scheduled_max_tasks        = 1
schedule_cron_service_out  = "cron(0 6 * * ? *)"
schedule_cron_service_in   = "cron(0 21 * * ? *)"

/* sg ingress ports 
ecs_ingress_ports = [
  3000,
  80
]

## service disc. 
dns_private_hosted_zone = "ecs.internal.ds"


# common task definition vars 
/*config_repo_prod       = "https://gitlab.agile.nat.bt.com/DOP/customer-selection-app.git"
config_repo_test       = "https://gitlab.agile.nat.bt.com/DOP/customer-selection-app.git"
config_repo_prod_branch = "main"
config_repo_test_branch = "feature/pit1"*/
