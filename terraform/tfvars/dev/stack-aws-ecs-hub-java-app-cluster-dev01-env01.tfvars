#ecs cluster
ecs_cluster_name = "hub-java-app"
container_insights = "enabled"
app_env = "env04"

# API specific vars
api = {
  "albert-knowledge-app" = {
    name                       = "albert-knowledge-app"
    port                       = "3000"
    repo_name                  = "ecr-dev01-env04-albert-knowledge-repo"
    target_group_arn           = "arn:aws:elasticloadbalancing:eu-west-2:770729963594:targetgroup/alb-tg-java-albertknwldge-env04/9a12bd208629a974"
    app_port                   = 3000
    app_name                   = "albert-knowledge"
    base_url                   = "/albert-knowledge"
    mem_reservation            = 1024
    hard_limit_cpu             = 512
    hard_limit_mem             = 1024
    desired_count              = 0
    min_tasks                  = 1
    max_tasks                  = 2
    #oneagent_repo_name         = "ecr-dev01-env04-one-agent-repo"
  },
  "app-broker-service" = {
    name                       = "app-broker-service"
    port                       = "3000"
    repo_name                  = "ecr-dev01-env04-app-broker-repo"
    target_group_arn           = "arn:aws:elasticloadbalancing:eu-west-2:770729963594:targetgroup/alb-tg-java-appbroker-env04/e09c0a9ea9cf3570"
    app_port                   = 3000
    app_name                   = "app-broker"
    base_url                   = "/app-broker"
    mem_reservation            = 1024
    hard_limit_cpu             = 512
    hard_limit_mem             = 1024
    desired_count              = 0
    min_tasks                  = 1
    max_tasks                  = 2
    #oneagent_repo_name         = "ecr-dev01-env04-one-agent-repo"
  }
}

# sg ingress ports 
ecs_ingress_ports = [
  3000,
  443
]

## service disc. 
dns_private_hosted_zone = "ecs.internal.ds"

# iam roles for ecs stack 
iam_roles = [
  "ecs-service",
  "ecs-task-execution",
  "ecs-autoscale"
]

# common task definition vars 
config_repo_prod       = "https://gitlab.agile.nat.bt.com/DOP/customer-selection-app.git"
config_repo_test       = "https://gitlab.agile.nat.bt.com/DOP/customer-selection-app.git"
config_repo_prod_branch = "main"
config_repo_test_branch = "feature/bf1"
container_essential    = true
port_mapping_protocol  = "tcp"
docker_networking_mode = "awsvpc"
containers_log_driver  = "awslogs"
launch_type            = "FARGATE"
#sourceVolume               = "oneagent"
#containerPath              = "/opt/dynatrace/oneagent"

alarm_memory_threshold_bytes = 600000000 #600MB  units in bytes
alarm_cpu_threshold_percent = 75
ok_actions    = [ ]
alarm_actions = [ ]