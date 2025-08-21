aws_region                    = "eu-west-2"
aws_profile_service_catalogue = "service-catalogue"

#hybrid-vpc
deploy_dcp_base_hybrid_vpc          = true
base_hybrid_vpc_elb_endpoint_option = true
base_hybrid_vpc_optin_version       = "v22"

#hybrid-dns
deploy_dcp_base_hybrid_dns      = true
base_hybrid_dns_optin_version   =  "v13"

#dynatrace
deploy_dcp_base_dynatrace = true
base_dynatrace_optin_version = "v2"
base_dynatrace_environment = "Consumer Prod (ssh69777)"
base_dynatrace_enablecloudwatchmetricstreams = false

# Event Framework
deploy_dcp_base_event_framework = true
base_event_framework_optin_version  = "v22"

# P1 variables
base_event_Priority1EmailOptIn     = true
base_event_Priority1EmailAddress   = "ee-portal-support@bt.com"
base_event_Priority1TeamsOptIn     = true
base_event_Priority1TeamsWebhook   = "https://btgroupcloud.webhook.office.com/webhookb2/83d958cc-40e9-452a-bf8f-8a242310965e@a7f35688-9c00-4d5e-ba41-29f146377ab0/IncomingWebhook/715e757c89d548658a8ebab7dc82b2fd/27700940-e329-4852-ba36-ba3d46e20bc9"
base_event_Priority1TicketingOptIn = true
base_event_Priority1TicketingQueue = "TPBTDIDCOGL2SUPPORT"

# P2 variables
base_event_Priority2EmailOptIn     = true
base_event_Priority2EmailAddress   = "ee-portal-support@bt.com"
base_event_Priority2TeamsOptIn     = true
base_event_Priority2TeamsWebhook   = "https://btgroupcloud.webhook.office.com/webhookb2/83d958cc-40e9-452a-bf8f-8a242310965e@a7f35688-9c00-4d5e-ba41-29f146377ab0/IncomingWebhook/2b90b1fe46d54644853a9f10e248e724/27700940-e329-4852-ba36-ba3d46e20bc9"
base_event_Priority2TicketingOptIn = true
base_event_Priority2TicketingQueue = "TPBTDIDCOGL2SUPPORT"

# P3 variables
base_event_Priority3EmailOptIn     = true
base_event_Priority3EmailAddress   = "ee-portal-support@bt.com"
base_event_Priority3TeamsOptIn     = true
base_event_Priority3TeamsWebhook   = "https://btgroupcloud.webhook.office.com/webhookb2/83d958cc-40e9-452a-bf8f-8a242310965e@a7f35688-9c00-4d5e-ba41-29f146377ab0/IncomingWebhook/583dc2969b1446e284b42f711c4d4106/27700940-e329-4852-ba36-ba3d46e20bc9"
base_event_Priority3TicketingOptIn = true
base_event_Priority3TicketingQueue = "TPBTDIDCOGL2SUPPORT"

# Informational variables
base_event_InformationalEmailOptIn   = true
base_event_InformationalEmailAddress = "ee-portal-support@bt.com"
base_event_InformationalTeamsOptIn   = true
base_event_InformationalTeamsWebhook = "https://btgroupcloud.webhook.office.com/webhookb2/83d958cc-40e9-452a-bf8f-8a242310965e@a7f35688-9c00-4d5e-ba41-29f146377ab0/IncomingWebhook/e4dc2c521e874b6c8c5061e4f96cb5e7/27700940-e329-4852-ba36-ba3d46e20bc9"

# Security variables
base_event_SecurityEmailOptIn     = true
base_event_SecurityEmailAddress   = "ee-portal-support@bt.com"
base_event_SecurityTeamsOptIn     = true
base_event_SecurityTeamsWebhook   = "https://btgroupcloud.webhook.office.com/webhookb2/83d958cc-40e9-452a-bf8f-8a242310965e@a7f35688-9c00-4d5e-ba41-29f146377ab0/IncomingWebhook/9a859f6f049342fab002c792cc20cb2b/27700940-e329-4852-ba36-ba3d46e20bc9"
base_event_SecurityTicketingOptIn = true
base_event_SecurityTicketingQueue = "TPBTDIDCOGL2SUPPORT"
