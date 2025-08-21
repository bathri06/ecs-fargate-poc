alb_hosted_zone = "app15421nh1.robt.euwe2.prd-plat.int.aws.bt.com"
enable_cross_zone_load_balancing = true
provider_configuration = {
  "hub" : {
    listeners = {
      /*"lsnr-hub-container-app" : {
        port            = 80
        protocol        = "HTTP"
        ssl_policy      = null
        certificate_arn = null
        #ssl_policy     = "ELBSecurityPolicy-2016-08"
        #certificate_arn = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"
      },*/
       "lsnr-hub-container-app-443" : {
        port            = 443
        protocol        = "HTTPS"
        ssl_policy     = "ELBSecurityPolicy-2016-08"
        certificate_arn = "arn:aws:acm:eu-west-2:775754714306:certificate/ef0e15de-9dce-4bc1-a37e-caf9c82e3257"
      }
    }
  }
}