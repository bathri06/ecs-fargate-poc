#eventbridge values
eventbridge_rule_name = "everyminuterun_processbatch"
event_schedule        = "cron(0/1 * * * ? *)"  #cron expression for every minute

#lambda function values
lambda_func_name      = "processbatch"
lambda_python_script  = "executeurl"
stack_instance        = "env01"
ssm_path              = "fqdn/internal/phpconverseappln"
service_urlpath       = "tsapi/schedule/despooler/process-batch"
runtime               = "python3.12"
timeout               = 30  #units in seconds

#cloudwatch alarms
cloudwatch_metric_alarms_enabled = true

threshold_lambda_errors = 5   #units in counts
period_lambda_errors = 300   #units in seconds

threshold_lambda_duration = 30000 #units in milliseconds
period_lambda_duration = 60  #units in seconds

threshold_lambda_innovations = 10 #units in count
period_lambda_innvocations = 60 #units in seconds

ok_actions    = ["arn:aws:sns:eu-west-2:100457310337:Dcp-BaseEvFw-Informational"]
alarm_actions = ["arn:aws:sns:eu-west-2:100457310337:Dcp-BaseEvFw-Informational"]