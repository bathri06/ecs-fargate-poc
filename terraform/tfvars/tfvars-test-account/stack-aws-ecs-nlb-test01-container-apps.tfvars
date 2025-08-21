nlb_hosted_zone = "app15421nh1.robt.euwe2.prd-plat.int.aws.bt.com"
provider_configuration = {
  "hub" : {
    full_service_name = "hub-container-application"
    friendly_domain_name : "hub-container-apps"
    target_groups = {
      /*"nlb-alb-tg-hub-container-app-80" : {
        "protocol" : "TCP"
        "port" : 80
        "target_type" : "alb"
        "health_check_protocol" : "HTTP"
        "health_check_enabled" : null
        "health_check_interval" : null
        "health_check_path" : null
        "health_check_port" : null
      },*/
        "nlb-alb-tg-hub-container-app-443" : {
        "protocol" : "TCP"
        "port" : 443
        "target_type" : "alb"
        "health_check_protocol" : "HTTPS"
        "health_check_enabled" : null
        "health_check_interval" : null
        "health_check_path" : null
        "health_check_port" : null
      }
    }
    listeners = {
      /*"nlb-alb-lsnr-hub-container-app-80" : {
        port            = 80
        protocol        = "TCP"
        ssl_policy      = null
        certificate_arn = null
        target_group    = "nlb-alb-tg-hub-container-app-80"
        forward         = {}
      },*/
      "nlb-alb-lsnr-hub-container-app-443" : {
        port            = 443
        protocol        = "TCP"
        ssl_policy      = null
        certificate_arn = null
        target_group    = "nlb-alb-tg-hub-container-app-443"
        forward         = {}
      }
    }
  }
}

#register targets
alb_name = "alb-container-apps-test01-hub"
#nlb_alb_tg_80_arn ="nlb-alb-tg-hub-container-app-80"
nlb_alb_tg_443_arn ="nlb-alb-tg-hub-container-app-443"
enable_cross_zone_load_balancing = true
