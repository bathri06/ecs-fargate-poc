consumer_configuration = {
  "hub" : {
    full_service_name = "hub-container-application"
    friendly_domain_name : "hub-container-apps"
    hybrid_sg_ingress_cidr_list = ["10.47.22.0/27", "10.47.22.32/27", "10.47.22.64/27"]
    hybrid_sg_ingress_port      = 443
    security_group_ids          = ["sg-01875b05f36f70f18", "sg-06f2122e5ee225aa1"]
  }
}