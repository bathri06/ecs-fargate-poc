nlb_hosted_zone = "app15421nh1.robt.euwe2.prd-plat.int.aws.bt.com"
provider_configuration = {
  "hub-containr-app" : {
    full_service_name = "hub-container-application"
    friendly_domain_name : "hub-container-apps"
    target_groups = {
      "nlb-alb-tg-hubcontainrapp-env04" : {
        "protocol" : "TCP"
        "port" : 443
        "target_type" : "alb"
        "health_check_protocol" : "HTTP"
        "health_check_enabled" : null
        "health_check_interval" : null
        "health_check_path" : null
        "health_check_port" : null
      }
    }
    listeners = {
      "nlb-alb-lsnr-hub-container-app-443-env04" : {
        port            = 443
        protocol        = "TCP"
        ssl_policy      = null
        certificate_arn = null
        target_group    = "nlb-alb-tg-hubcontainrapp-env04"
        forward         = {}
      }
    }
  }
}
alb_name = "alb-env04-dev01-hub-containr-app"
nlb_alb_tg_arn ="nlb-alb-tg-hubcontainrapp-env04"
alb_provider_configuration = "hub-containr-app"
enable_cross_zone_load_balancing = true
