aws_region  = "eu-west-2"
aws_profile = "administrator"

asg_common_name                   = "asg"
additional_vpc_security_group_ids = ["sg-07f1f671f8ea41548", "sg-0c20ab3639b148ada"]

ansible_inventory_name = "inventory_aws_hub_test"
ansible_inventory_url  = "https://gitlab.agile.nat.bt.com/APP15421/dcp/ansible/inventories"

http_tokens = "required"

nlb_tg_data_lookup    = true
asg_health_check_type = "EC2"

tag_isproduction = "false"
tag_patchgroup   = "1"

# AMI versions for tiers either 'DevId' OR 'LatestId' OR 'v1.0.0' (version number of tagged AMI)
php_convrs_application_ami_version  = "LatestId"

# Schedular variables
night_schedule_min_capacity     = "0"
night_schedule_max_capacity     = "0"
night_schedule_desired_capacity = "0"
night_schedule_recurrence       = "00 19 * * 1-5"
morning_schedule_recurrence     = "00 03 * * 1-5"

php_convrs_application_configuration = {
  "cluster_role_name"             = "php_converse_application"
  "asg_min_capacity"              = "1"
  "asg_max_capacity"              = "1"
  "asg_desired_capacity"          = "1"
  "asg_wait_for_capacity_timeout" = "20m"
  "ansible_inventory_host"        = "php_converse"
  "ansible_inventory_branch"      = "feature/APP15421-pit-master"
  "ansible_playbook_name"         = "php-converse.yml"
  "ansible_role_refresh"          = "false"
  "target_group_arns"             = []
  "launch_template_overrides" = [
    {
      "instance_type" = "m5.large"
    },
    {
      "instance_type" = "r5.xlarge"
    },
  ]
  "block_device_mappings" = [
    {
      device_name = "/dev/xvda"
      ebs = {
        volume_type           = "gp3"
        volume_size           = "50"
        delete_on_termination = true
        encrypted             = true
      }
    },
    {
      device_name = "/dev/sdf"
      ebs = {
        volume_type           = "gp3"
        volume_size           = "50"
        delete_on_termination = true
        encrypted             = true
      }
    },
    {
      device_name = "/dev/sdg"
      ebs = {
        volume_type           = "gp3"
        volume_size           = "50"
        delete_on_termination = true
        encrypted             = true
      }
    }
  ]
  autoscaling_policies_enabled = true
  scale_up_scaling_adjustment  = 1
  scale_up_adjustment_type     = "ChangeInCapacity"
  scale_up_policy_type         = "SimpleScaling"
  scale_up_cooldown_seconds    = 180

  scale_down_scaling_adjustment = -1
  scale_down_adjustment_type    = "ChangeInCapacity"
  scale_down_policy_type        = "SimpleScaling"
  scale_down_cooldown_seconds   = 120

  scaleup_alarm_comparison_operator       = "GreaterThanOrEqualToThreshold"
  scaleup_alarm_evaluation_periods        = 5
  scaleup_alarm_metric_name               = "CPUUtilization"
  scaleup_alarm_namespace                 = "AWS/EC2"
  scaleup_alarm_period                    = 120
  scaleup_alarm_statistic                 = "Average"
  scaleup_alarm_threshold                 = 40
  scaleup_alarm_treat_missing_data        = "missing"
  scaleup_alarm_ok_actions                = ["arn:aws:sns:eu-west-2:775754714306:Dcp-BaseEvFw-Informational"]
  scaleup_alarm_insufficient_data_actions = []
  scaleup_alarm_alarm_description         = "This metric monitors ec2 memory for High utilization on hosts"

  scaledown_alarm_comparison_operator       = "LessThanOrEqualToThreshold"
  scaledown_alarm_evaluation_periods        = 5
  scaledown_alarm_metric_name               = "CPUUtilization"
  scaledown_alarm_namespace                 = "AWS/EC2"
  scaledown_alarm_period                    = 120
  scaledown_alarm_statistic                 = "Average"
  scaledown_alarm_threshold                 = 10
  scaledown_alarm_treat_missing_data        = "missing"
  scaledown_alarm_ok_actions                = ["arn:aws:sns:eu-west-2:775754714306:Dcp-BaseEvFw-Informational"]
  scaledown_alarm_insufficient_data_actions = []
  scaledown_alarm_alarm_description         = "This metric monitors ec2 memory for low utilization on hosts"
}

#Cloudwatch Log groups for all the tiers
cwlg_hub_applications = {
  "cwlg-test01-env01-php-converse-httpd-ssl-access" = {
    "log_group_retention_period"   = 07
    "log_group_storage_class"	     = "STANDARD"
    "log_group_ssm_parameter_path" = "/app15421/test01/env01/cw/php-converse/httpd-ssl-access-loggroup-name"
  },
  "cwlg-test01-env01-php-converse-httpd-ssl-error" = {
    "log_group_retention_period"   = 07
    "log_group_storage_class"	     = "STANDARD"
    "log_group_ssm_parameter_path" = "/app15421/test01/env01/cw/php-converse/httpd-ssl-error-loggroup-name"
  },
  "cwlg-test01-env01-php-converse-gearmand" = {
    "log_group_retention_period"   = 07
    "log_group_storage_class"	     = "STANDARD"
    "log_group_ssm_parameter_path" = "/app15421/test01/env01/cw/php-converse/gearmand-loggroup-name"
  },
  "cwlg-test01-env01-php-converse-php-access" = {
    "log_group_retention_period"   = 07
    "log_group_storage_class"	     = "STANDARD"
    "log_group_ssm_parameter_path" = "/app15421/test01/env01/cw/php-converse/php-access-loggroup-name"
  },
  "cwlg-test01-env01-php-converse-php-error" = {
    "log_group_retention_period"   = 07
    "log_group_storage_class"	     = "STANDARD"
    "log_group_ssm_parameter_path" = "/app15421/test01/env01/cw/php-converse/php-error-loggroup-name"
  },
  "cwlg-test01-env01-php-converse-app-authentication" = {
    "log_group_retention_period"   = 07
    "log_group_storage_class"	     = "STANDARD"
    "log_group_ssm_parameter_path" = "/app15421/test01/env01/cw/php-converse/php-converse-app-authentication-loggroup-name"
  },
  "cwlg-test01-env01-php-converse-app-apperr" = {
    "log_group_retention_period"   = 07
    "log_group_storage_class"	     = "STANDARD"
    "log_group_ssm_parameter_path" = "/app15421/test01/env01/cw/php-converse/php-converse-app-apperr-loggroup-name"
  },
  "cwlg-test01-env01-php-converse-app-soap" = {
    "log_group_retention_period"   = 07
    "log_group_storage_class"	     = "STANDARD"
    "log_group_ssm_parameter_path" = "/app15421/test01/env01/cw/php-converse/php-converse-app-soap-loggroup-name"
  },
  "cwlg-test01-env01-php-converse-app-tsapi-actioner-audit" = {
    "log_group_retention_period"   = 07
    "log_group_storage_class"	     = "STANDARD"
    "log_group_ssm_parameter_path" = "/app15421/test01/env01/cw/php-converse/php-converse-app-tsapi-actioner-audit-loggroup-name"
  },
  "cwlg-test01-env01-php-converse-app-tsapi-dialogue-execute" = {
    "log_group_retention_period"   = 07
    "log_group_storage_class"	     = "STANDARD"
    "log_group_ssm_parameter_path" = "/app15421/test01/env01/cw/php-converse/php-converse-app-tsapi-dialogue-execute-loggroup-name"
  },
  "cwlg-test01-env01-php-converse-app-application" = {
    "log_group_retention_period"   = 07
    "log_group_storage_class"	     = "STANDARD"
    "log_group_ssm_parameter_path" = "/app15421/test01/env01/cw/php-converse/php-converse-app-application-loggroup-name"
  },
   "cwlg-test01-env01-php-converse-app-rest" = {
    "log_group_retention_period"   = 07
    "log_group_storage_class"	     = "STANDARD"
    "log_group_ssm_parameter_path" = "/app15421/test01/env01/cw/php-converse/php-converse-app-rest-loggroup-name"
  },
  "cwlg-test01-env01-php-converse-mem" = {
    "log_group_retention_period"   = 07
    "log_group_storage_class"	     = "STANDARD"
    "log_group_ssm_parameter_path" = "/app15421/test01/env01/cw/php-converse/php_converse-mem-loggroup-name"
  },
  "cwlg-test01-env01-php-converse-cpu" = {
    "log_group_retention_period"   = 07
    "log_group_storage_class"	     = "STANDARD"
    "log_group_ssm_parameter_path" = "/app15421/test01/env01/cw/php-converse/php_converse-cpu-loggroup-name"
  },
  "cwlg-test01-env01-php-converse-disk" = {
    "log_group_retention_period"   = 07
    "log_group_storage_class"	     = "STANDARD"
    "log_group_ssm_parameter_path" = "/app15421/test01/env01/cw/php-converse/php_converse-disk-loggroup-name"
  },
  "cwlg-test01-env01-php-converse-cloudinit" = {
    "log_group_retention_period"   = 07
    "log_group_storage_class"	     = "STANDARD"
    "log_group_ssm_parameter_path" = "/app15421/test01/env01/cw/php-converse/php_converse-cloudinit-loggroup-name"
  },
  "cwlg-test01-env01-php-converse-phplog" = {
    "log_group_retention_period"   = 07
    "log_group_storage_class"	     = "STANDARD"
    "log_group_ssm_parameter_path" = "/app15421/test01/env01/cw/php-converse/php_converse-phplog-loggroup-name"
  },
  "cwlg-test01-env01-php-converse-httpdprocess" = {
    "log_group_retention_period"   = 07
    "log_group_storage_class"	     = "STANDARD"
    "log_group_ssm_parameter_path" = "/app15421/test01/env01/cw/php-converse/php_converse-httpdprocess-loggroup-name"
  },
  "cwlg-test01-env01-php-converse-gearmandprocess" = {
    "log_group_retention_period"   = 07
    "log_group_storage_class"	     = "STANDARD"
    "log_group_ssm_parameter_path" = "/app15421/test01/env01/cw/php-converse/php_converse-gearmandprocess-loggroup-name"
  },
  "cwlg-test01-env01-php-converse-phpprocess" = {
    "log_group_retention_period"   = 07
    "log_group_storage_class"	     = "STANDARD"
    "log_group_ssm_parameter_path" = "/app15421/test01/env01/cw/php-converse/php_converse-phpprocess-loggroup-name"
  }
}

#Cloudwatch metric filters and alarms based on log groups
cwlg_hub_metric_filters = {
  "php_converse_test01_env01_memory_metric" = {
    "cwlg_metric_filter_pattern"       = "ERROR"
    "cwlg_metric_filter_loggroup_name" = "cwlg-test01-env01-php-converse-mem"
    "cwlg_metric_filter_mt_name"       = "php_converse_test01_env01_memory_metric"
    "cwlg_metric_filter_mt_namespace"  = "php-converse"
    "cwlg_metric_filter_mt_value"      = "1"
  },
  "php_converse_test01_env01_cpu_metric" = {
    "cwlg_metric_filter_pattern"       = "ERROR"
    "cwlg_metric_filter_loggroup_name" = "cwlg-test01-env01-php-converse-cpu"
    "cwlg_metric_filter_mt_name"       = "php_converse_test01_env01_cpu_metric"
    "cwlg_metric_filter_mt_namespace"  = "php-converse"
    "cwlg_metric_filter_mt_value"      = "1"
  },
  "php_converse_test01_env01_disk_metric" = {
    "cwlg_metric_filter_pattern"       = "ERROR"
    "cwlg_metric_filter_loggroup_name" = "cwlg-test01-env01-php-converse-disk"
    "cwlg_metric_filter_mt_name"       = "php_converse_test01_env01_disk_metric"
    "cwlg_metric_filter_mt_namespace"  = "php-converse"
    "cwlg_metric_filter_mt_value"      = "1"
    },
  "php_converse_test01_env01_phplog_metric" = {
    "cwlg_metric_filter_pattern"       = "ERROR"
    "cwlg_metric_filter_loggroup_name" = "cwlg-test01-env01-php-converse-phplog"
    "cwlg_metric_filter_mt_name"       = "php_converse_test01_env01_phplog_metric"
    "cwlg_metric_filter_mt_namespace"  = "php-converse"
    "cwlg_metric_filter_mt_value"      = "1"
  },
  "php_converse_test01_env01_phpfpm_restart_metric" = {
    "cwlg_metric_filter_pattern"       = "RESTARTINFO"
    "cwlg_metric_filter_loggroup_name" = "cwlg-test01-env01-php-converse-phplog"
    "cwlg_metric_filter_mt_name"       = "php_converse_test01_env01_phpfpm_restart_metric"
    "cwlg_metric_filter_mt_namespace"  = "php-converse"
    "cwlg_metric_filter_mt_value"      = "1"
  },
  "php_converse_test01_env01_httpdprocess_metric" = {
    "cwlg_metric_filter_pattern"       = "ERROR"
    "cwlg_metric_filter_loggroup_name" = "cwlg-test01-env01-php-converse-httpdprocess"
    "cwlg_metric_filter_mt_name"       = "php_converse_test01_env01_httpdprocess_metric"
    "cwlg_metric_filter_mt_namespace"  = "php-converse"
    "cwlg_metric_filter_mt_value"      = "1"
  },
  "php_converse_test01_env01_gearmandprocess_metric" = {
    "cwlg_metric_filter_pattern"       = "ERROR"
    "cwlg_metric_filter_loggroup_name" = "cwlg-test01-env01-php-converse-gearmandprocess"
    "cwlg_metric_filter_mt_name"       = "php_converse_test01_env01_gearmandprocess_metric"
    "cwlg_metric_filter_mt_namespace"  = "php-converse"
    "cwlg_metric_filter_mt_value"      = "1"
  },
  "php_converse_test01_env01_phpprocess_metric" = {
    "cwlg_metric_filter_pattern"       = "ERROR"
    "cwlg_metric_filter_loggroup_name" = "cwlg-test01-env01-php-converse-phpprocess"
    "cwlg_metric_filter_mt_name"       = "php_converse_test01_env01_phpprocess_metric"
    "cwlg_metric_filter_mt_namespace"  = "php-converse"
    "cwlg_metric_filter_mt_value"      = "1"
  },
  "php_converse_test01_env01_cloudinit_metric" = {
    "cwlg_metric_filter_pattern"       = "ERROR"
    "cwlg_metric_filter_loggroup_name" = "cwlg-test01-env01-php-converse-cloudinit"
    "cwlg_metric_filter_mt_name"       = "php_converse_test01_env01_cloudinit_metric"
    "cwlg_metric_filter_mt_namespace"  = "php-converse"
    "cwlg_metric_filter_mt_value"      = "1"
  },
  "php_converse_test01_env01_tsapi_dialogue_cache_error" = {
    "cwlg_metric_filter_pattern"       = "Emergency cache error occurred while get dialogue"
    "cwlg_metric_filter_loggroup_name" = "cwlg-test01-env01-php-converse-app-tsapi-dialogue-execute"
    "cwlg_metric_filter_mt_name"       = "php_converse_test01_env01_tsapi_dialogue_cache_error"
    "cwlg_metric_filter_mt_namespace"  = "php-converse"
    "cwlg_metric_filter_mt_value"      = "1"
  }
}

cwlg_hub_alarms = {
  "php_converse_test01_env01_memory_problem" = {
    "cwlg_alarm_comparision_operator"      = "GreaterThanThreshold"
    "cwlg_alarm_evaluation_periods"        = "1"
    "cwlg_alarm_metric_name"               = "php_converse_test01_env01_memory_metric"
    "cwlg_alarm_datapoints_to_alarm"       = "1"
    "cwlg_alarm_metric_namespace"          = "php-converse"
    "cwlg_alarm_period"                    = "120"
    "cwlg_alarm_statistic"                 = "SampleCount"
    "cwlg_alarm_threshold"                 = "0"
    "cwlg_alarm_description"               = "This metric validates the php converse memory status"
    "cwlg_alarm_treat_missing_data"        = "notBreaching"
    "cwlg_alarm_actions"                   = ["arn:aws:sns:eu-west-2:775754714306:Dcp-BaseEvFw-Informational"]
    "cwlg_alarm_insufficient_data_actions" = []
  },
  "php_converse_test01_env01_cpu_problem" = {
    "cwlg_alarm_comparision_operator"      = "GreaterThanThreshold"
    "cwlg_alarm_evaluation_periods"        = "1"
    "cwlg_alarm_metric_name"               = "php_converse_test01_env01_cpu_metric"
    "cwlg_alarm_datapoints_to_alarm"       = "1"
    "cwlg_alarm_metric_namespace"          = "php-converse"
    "cwlg_alarm_period"                    = "120"
    "cwlg_alarm_statistic"                 = "SampleCount"
    "cwlg_alarm_threshold"                 = "0"
    "cwlg_alarm_description"               = "This metric validates the php converse cpu status"
    "cwlg_alarm_treat_missing_data"        = "notBreaching"
    "cwlg_alarm_actions"                   = ["arn:aws:sns:eu-west-2:775754714306:Dcp-BaseEvFw-Informational"]
    "cwlg_alarm_insufficient_data_actions" = []
  },
  "php_converse_test01_env01_disk_problem" = {
    "cwlg_alarm_comparision_operator"      = "GreaterThanThreshold"
    "cwlg_alarm_evaluation_periods"        = "1"
    "cwlg_alarm_metric_name"               = "php_converse_test01_env01_disk_metric"
    "cwlg_alarm_datapoints_to_alarm"       = "1"
    "cwlg_alarm_metric_namespace"          = "php-converse"
    "cwlg_alarm_period"                    = "120"
    "cwlg_alarm_statistic"                 = "SampleCount"
    "cwlg_alarm_threshold"                 = "0"
    "cwlg_alarm_description"               = "This metric validates the php converse disk status"
    "cwlg_alarm_treat_missing_data"        = "notBreaching"
    "cwlg_alarm_actions"                   = ["arn:aws:sns:eu-west-2:775754714306:Dcp-BaseEvFw-Informational"]
    "cwlg_alarm_insufficient_data_actions" = []
    },
  "php_converse_test01_env01_phplog_problem" = {
    "cwlg_alarm_comparision_operator"      = "GreaterThanThreshold"
    "cwlg_alarm_evaluation_periods"        = "1"
    "cwlg_alarm_metric_name"               = "php_converse_test01_env01_phplog_metric"
    "cwlg_alarm_datapoints_to_alarm"       = "1"
    "cwlg_alarm_metric_namespace"          = "php-converse"
    "cwlg_alarm_period"                    = "120"
    "cwlg_alarm_statistic"                 = "SampleCount"
    "cwlg_alarm_threshold"                 = "0"
    "cwlg_alarm_description"               = "This metric validates the php converse phplog status"
    "cwlg_alarm_treat_missing_data"        = "notBreaching"
    "cwlg_alarm_actions"                   = ["arn:aws:sns:eu-west-2:775754714306:Dcp-BaseEvFw-Informational"]
    "cwlg_alarm_insufficient_data_actions" = []
  },
  "php_converse_test01_env01_httpdprocess_problem" = {
    "cwlg_alarm_comparision_operator"      = "GreaterThanThreshold"
    "cwlg_alarm_evaluation_periods"        = "1"
    "cwlg_alarm_metric_name"               = "php_converse_test01_env01_httpdprocess_metric"
    "cwlg_alarm_datapoints_to_alarm"       = "1"
    "cwlg_alarm_metric_namespace"          = "php-converse"
    "cwlg_alarm_period"                    = "120"
    "cwlg_alarm_statistic"                 = "SampleCount"
    "cwlg_alarm_threshold"                 = "0"
    "cwlg_alarm_description"               = "This metric validates the php converse httpdprocess status"
    "cwlg_alarm_treat_missing_data"        = "notBreaching"
    "cwlg_alarm_actions"                   = ["arn:aws:sns:eu-west-2:775754714306:Dcp-BaseEvFw-Informational"]
    "cwlg_alarm_insufficient_data_actions" = []
  },
  "php_converse_test01_env01_gearmandprocess_problem" = {
    "cwlg_alarm_comparision_operator"      = "GreaterThanThreshold"
    "cwlg_alarm_evaluation_periods"        = "1"
    "cwlg_alarm_metric_name"               = "php_converse_test01_env01_gearmandprocess_metric"
    "cwlg_alarm_datapoints_to_alarm"       = "1"
    "cwlg_alarm_metric_namespace"          = "php-converse"
    "cwlg_alarm_period"                    = "120"
    "cwlg_alarm_statistic"                 = "SampleCount"
    "cwlg_alarm_threshold"                 = "0"
    "cwlg_alarm_description"               = "This metric validates the php converse gearmandprocess status"
    "cwlg_alarm_treat_missing_data"        = "notBreaching"
    "cwlg_alarm_actions"                   = ["arn:aws:sns:eu-west-2:775754714306:Dcp-BaseEvFw-Informational"]
    "cwlg_alarm_insufficient_data_actions" = []
  },
  "php_converse_test01_env01_phpprocess_problem" = {
    "cwlg_alarm_comparision_operator"      = "GreaterThanThreshold"
    "cwlg_alarm_evaluation_periods"        = "1"
    "cwlg_alarm_metric_name"               = "php_converse_test01_env01_phpprocess_metric"
    "cwlg_alarm_datapoints_to_alarm"       = "1"
    "cwlg_alarm_metric_namespace"          = "php-converse"
    "cwlg_alarm_period"                    = "120"
    "cwlg_alarm_statistic"                 = "SampleCount"
    "cwlg_alarm_threshold"                 = "0"
    "cwlg_alarm_description"               = "This metric validates the php converse phpprocess status"
    "cwlg_alarm_treat_missing_data"        = "notBreaching"
    "cwlg_alarm_actions"                   = ["arn:aws:sns:eu-west-2:775754714306:Dcp-BaseEvFw-Informational"]
    "cwlg_alarm_insufficient_data_actions" = []
  },
  "php_converse_test01_env01_cloudinit_problem" = {
    "cwlg_alarm_comparision_operator"      = "GreaterThanThreshold"
    "cwlg_alarm_evaluation_periods"        = "1"
    "cwlg_alarm_metric_name"               = "php_converse_test01_env01_cloudinit_metric"
    "cwlg_alarm_datapoints_to_alarm"       = "1"
    "cwlg_alarm_metric_namespace"          = "php-converse"
    "cwlg_alarm_period"                    = "120"
    "cwlg_alarm_statistic"                 = "SampleCount"
    "cwlg_alarm_threshold"                 = "0"
    "cwlg_alarm_description"               = "This metric validates the php converse cloudinit status"
    "cwlg_alarm_treat_missing_data"        = "notBreaching"
    "cwlg_alarm_actions"                   = ["arn:aws:sns:eu-west-2:775754714306:Dcp-BaseEvFw-Informational"]
    "cwlg_alarm_insufficient_data_actions" = []
  },
  "php_converse_test01_env01_phpfpm_restart" = {
    "cwlg_alarm_comparision_operator"      = "GreaterThanThreshold"
    "cwlg_alarm_evaluation_periods"        = "1"
    "cwlg_alarm_metric_name"               = "php_converse_test01_env01_phpfpm_restart_metric"
    "cwlg_alarm_datapoints_to_alarm"       = "1"
    "cwlg_alarm_metric_namespace"          = "php-converse"
    "cwlg_alarm_period"                    = "120"
    "cwlg_alarm_statistic"                 = "SampleCount"
    "cwlg_alarm_threshold"                 = "0"
    "cwlg_alarm_description"               = "Php converse has been restarted on an instance"
    "cwlg_alarm_treat_missing_data"        = "notBreaching"
    "cwlg_alarm_actions"                   = ["arn:aws:sns:eu-west-2:775754714306:Dcp-BaseEvFw-Informational"]
    "cwlg_alarm_insufficient_data_actions" = []
  },
  "php_converse_test01_env01_tsapi_dialogue_cache_error" = {
    "cwlg_alarm_comparision_operator"      = "GreaterThanThreshold"
    "cwlg_alarm_evaluation_periods"        = "1"
    "cwlg_alarm_metric_name"               = "php_converse_test01_env01_tsapi_dialogue_cache_error"
    "cwlg_alarm_datapoints_to_alarm"       = "1"
    "cwlg_alarm_metric_namespace"          = "php-converse"
    "cwlg_alarm_period"                    = "120"
    "cwlg_alarm_statistic"                 = "SampleCount"
    "cwlg_alarm_threshold"                 = "0"
    "cwlg_alarm_description"               = "This metric validates the php converse cache error status in dialogue execute log"
    "cwlg_alarm_treat_missing_data"        = "notBreaching"
    "cwlg_alarm_actions"                   = ["arn:aws:sns:eu-west-2:775754714306:Dcp-BaseEvFw-Informational"]
    "cwlg_alarm_insufficient_data_actions" = []
  }
}

#hub-hosted-application
nlb_hosted_zone = "app15421nh1.robt.euwe2.prd-plat.int.aws.bt.com"

provider_configuration = {
  "php-convrs-app" : {

    full_service_name = "hub-php-convrs-application"
    friendly_domain_name : "hub-php-convrs-apps"
    target_groups = {
      "nlb-tg-php-convrs-app-8443-env01" : {
        "protocol" : "tcp"
        "port" : 8443
        "target_type" : "instance"
        "preserve_client_ip" : false
        "health_check_protocol" : "HTTPS"
        "health_check_enabled" : true
        "health_check_interval" : 10
        "health_check_path" : "/Probe"
        "health_check_port" : 8443
        #"health_check_matcher" : "200"
      },
      "nlb-tg-php-convrs-app-8080-env01" : {
        "protocol" : "tcp"
        "port" : 8080
        "target_type" : "instance"
        "preserve_client_ip" : false
        "health_check_protocol" : "HTTP"
        "health_check_enabled" : true
        "health_check_interval" : 10
        "health_check_path" : "/Probe"
        "health_check_port" : 8080
        #"health_check_matcher" : "200"
      }
    }
    listeners = {
      "nlb-lsnr-php-convrs-app-443-env01" : {
        port            = 443
        protocol        = "tcp"
        ssl_policy      = null
        certificate_arn = null
        target_group    = "nlb-tg-php-convrs-app-8443-env01"
        forward         = {}
      },
      "nlb-lsnr-php-convrs-app-80-env01" : {
        port            = 80
        protocol        = "tcp"
        ssl_policy      = null
        certificate_arn = null
        target_group    = "nlb-tg-php-convrs-app-8080-env01"
        forward         = {}
      }
    }
  }
}
enable_cross_zone_load_balancing = true
