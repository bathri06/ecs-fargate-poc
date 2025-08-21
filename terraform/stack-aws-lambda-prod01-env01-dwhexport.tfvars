#eventbridge values
eventbridge_rule_name = "every15minutesrun_dwhexport"
event_schedule        = "cron(0/15 * * * ? *)"  #cron expression for every 15 minutes

#lambda function values
lambda_func_name      = "dwhexport"
lambda_python_script  = "executeurl"
stack_instance        = "env01"
ssm_path              = "fqdn/internal/phpconverseappln"
service_urlpath       = "tsapi/schedule/dwh-export"
runtime               = "python3.12"
timeout               = 30  #units in seconds

#cloudwatch alarms
cloudwatch_metric_alarms_enabled = true

#lambda_errors
threshold_lambda_errors = 3  #units in counts
period_lambda_errors = 3600   #units in seconds #60 minutes

#lambda_duration
threshold_lambda_duration = 60000 #units in milliseconds
period_lambda_duration = 900  #units in seconds

threshold_lambda_innovations = 10 #units in count
period_lambda_innvocations = 1800 #units in seconds

ok_actions    = ["arn:aws:sns:eu-west-2:100457310337:Dcp-BaseEvFw-Informational"]
alarm_actions = ["arn:aws:sns:eu-west-2:100457310337:Dcp-BaseEvFw-Informational"]