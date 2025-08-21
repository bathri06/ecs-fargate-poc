provider_configuration = {
  "customer-select-app-env01" : {
     listener_rule_forward = {
      "ls-rule-customer-select-app-env01" : {
         listener_arn  = "arn:aws:elasticloadbalancing:eu-west-2:775754714306:listener/app/alb-container-apps-test01-hub/604b4d2cf900d18f/e5101cc3951f1879"
         target_group = "alb-tg-customer-select-app-env01"
         path_values  = ["/react-app/customer-selection","/react-app/customer-selection/*"]
         host_header_values = ["hub-container-apps.container-apps.test01.app15421nh1.robt.euwe2.prd-plat.int.aws.bt.com"]
         forward      = {}
      },
      "ls-rule-assisted-merge-app-env01" : {
         listener_arn  = "arn:aws:elasticloadbalancing:eu-west-2:775754714306:listener/app/alb-container-apps-test01-hub/604b4d2cf900d18f/e5101cc3951f1879"
         target_group = "alb-tg-assisted-merge-app-env01"
         path_values  = ["/react-app/assisted-merge","/react-app/assisted-merge/*"]
         host_header_values = ["hub-container-apps.container-apps.test01.app15421nh1.robt.euwe2.prd-plat.int.aws.bt.com"]
         forward      = {}
      }
    }
    target_groups = {
      "alb-tg-customer-select-app-env01" : {
        "protocol" : "HTTP"
        "port" : 3000
        "target_type" : "ip"
        "health_check_protocol" : "HTTP"
        "health_check_enabled" : true
        "health_check_interval" : 30
        "health_check_path" : "/react-app/customer-selection/health"
        "health_check_port" : 3000
      },
       "alb-tg-assisted-merge-app-env01" : {
        "protocol" : "HTTP"
        "port" : 3000
        "target_type" : "ip"
        "health_check_protocol" : "HTTP"
        "health_check_enabled" : true
        "health_check_interval" : 30
        "health_check_path" : "/react-app/assisted-merge/health"
        "health_check_port" : 3000
      }
    } 
  }
}