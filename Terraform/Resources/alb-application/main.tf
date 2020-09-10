module "application_load_balancer" {
    source                           = "../../Modules/alb"
    create_lb                        = var.create_lb
    name                             = var.name
    is_load_balancer_internal        = var.is_load_balancer_internal
    security_groups                  = concat([aws_security_group.tf_sg.id], [data.terraform_remote_state.vpc.outputs.vpc_default_security_group_id[0]])
    subnets                          = data.aws_subnet_ids.subnet_ids.ids
    idle_timeout                     = var.idle_timeout
    enable_deletion_protection       = var.enable_deletion_protection
    enable_cross_zone_load_balancing = var.enable_cross_zone_load_balancing
    enable_http2                     = var.enable_http2
    ip_address_type                  = var.ip_address_type
    subnet_mapping                   = var.subnet_mapping
    lb_tags                          = var.lb_tags
    lb_create_timeout                = var.lb_create_timeout
    lb_update_timeout                = var.lb_update_timeout
    lb_delete_timeout                = var.lb_delete_timeout
    target_groups                    = var.target_groups
    vpc_id                           = data.terraform_remote_state.vpc.outputs.vpc_id[0]
    stickiness                       = var.stickiness
    health_check                     = var.health_check
    tg_tags                          = var.tg_tags
    http_tcp_listeners               = var.http_tcp_listeners
    https_listeners                  = var.https_listeners
}

####-----Outputs Section-----####

output "lb_arn" {
    value = module.application_load_balancer.alb_arn
}

output "lb_dns_name" {
    value = module.application_load_balancer.alb_dns_name
}

output "lb_tg_arn" {
    value = module.application_load_balancer.tg_arn
}