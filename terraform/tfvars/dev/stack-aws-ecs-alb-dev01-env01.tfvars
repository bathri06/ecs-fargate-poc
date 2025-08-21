alb_hosted_zone = "app15421nh1.robt.euwe2.prd-plat.int.aws.bt.com"
provider_configuration = {

  "hub-containr-app" : {
    listeners = {
      "alb-lsnr-hubcontainrapp-env04" : {
        port            = 443
        protocol        = "HTTP"
        ssl_policy      = null
        certificate_arn = null
        #ssl_policy     = "ELBSecurityPolicy-2016-08"
        #certificate_arn = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"
        #target_group    = "alb-tg-hubcontainrapp-env04"
        #forward         = {}
      }
    }
     listener_rule_forward = {
      "lsnr-rule-customer-selection-env04" : {
         listenerarn_forward  = "alb-lsnr-hubcontainrapp-env04"
         priority     = 1
         target_group = "alb-tg-customer-selection-env04"
         values       = ["/customer-selection-service"]
         forward      = {}
      },
      "lsnr-rule-skeleton-App-env04" : {
         listenerarn_forward  = "alb-lsnr-hubcontainrapp-env04"
         priority     = 2
         target_group = "alb-tg-skeleton-app-env04"
         values       = ["/skeleton-app"]
         forward      = {}
      },
      "lsnr-rule-java-albertknwldge-env04" : {
         listenerarn_forward  = "alb-lsnr-hubcontainrapp-env04"
         priority     = 3
         target_group = "alb-tg-java-albertknwldge-env04"
         values       = ["/albert-knowledge"]
         forward      = {}
      },
      "lsnr-rule-java-appbroker-env04" : {
         listenerarn_forward  = "alb-lsnr-hubcontainrapp-env04"
         priority     = 4
         target_group = "alb-tg-java-appbroker-env04"
         values       = ["/app-broker"]
         forward      = {}
      }
    }
    target_groups = {
      "alb-tg-customer-selection-env04" : {
        "protocol" : "HTTP"
        "port" : 3000
        "target_type" : "ip"
        "health_check_protocol" : "HTTP"
        "health_check_enabled" : true
        "health_check_interval" : 30
        "health_check_path" : "/"
        "health_check_port" : 3000
      },
      "alb-tg-skeleton-app-env04" : {
        "protocol" : "HTTP"
        "port" : 3000
        "target_type" : "ip"
        "health_check_protocol" : "HTTP"
        "health_check_enabled" : true
        "health_check_interval" : 30
        "health_check_path" : "/"
        "health_check_port" : 3000
      },
      "alb-tg-java-albertknwldge-env04" : {
        "protocol" : "HTTP"
        "port" : 3000
        "target_type" : "ip"
        "health_check_protocol" : "HTTP"
        "health_check_enabled" : true
        "health_check_interval" : 30
        "health_check_path" : "/"
        "health_check_port" : 3000
      },
      "alb-tg-java-appbroker-env04" : {
        "protocol" : "HTTP"
        "port" : 3000
        "target_type" : "ip"
        "health_check_protocol" : "HTTP"
        "health_check_enabled" : true
        "health_check_interval" : 30
        "health_check_path" : "/"
        "health_check_port" : 3000
      }
    } 
  }
}

enable_cross_zone_load_balancing = true
