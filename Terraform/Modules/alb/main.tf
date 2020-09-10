resource "aws_lb" "tf_alb" {
    name                             = var.name
    internal                         = var.is_load_balancer_internal
    load_balancer_type               = "application"
    security_groups                  = var.security_groups
    subnets                          = var.subnets
    idle_timeout                     = var.idle_timeout
    enable_deletion_protection       = var.enable_deletion_protection
    enable_cross_zone_load_balancing = var.enable_cross_zone_load_balancing
    enable_http2                     = var.enable_http2
    ip_address_type                  = var.ip_address_type

    #dynamic "access_logs" {
    #   for_each = var.access_logs

    #    content {
    #        enabled = var.enabled
    #        bucket  = var.bucket_name
    #        prefix  = var.bucket_prefix
    #    }
    #}

    dynamic "subnet_mapping" {
        for_each = var.subnet_mapping

        content {
            subnet_id = var.subnet_id
        }
    }
    
    tags  = merge({"Name" = var.name}, var.lb_tags)

    timeouts {
        create = var.lb_create_timeout
        update = var.lb_update_timeout
        delete = var.lb_delete_timeout
    }
}

resource "aws_lb_target_group" "tf_target_group" {
    count = var.create_lb ? length(var.target_groups) : 0
    name  = lookup(var.target_groups[count.index], "name")
    port  = lookup(var.target_groups[count.index], "port")
    protocol = lookup(var.target_groups[count.index], "protocol")
    vpc_id   = var.vpc_id
    deregistration_delay = lookup(var.target_groups[count.index], "deregistration_delay", lookup(local.tg_defaults, "deregistration_delay"))
    target_type = lookup(var.target_groups[count.index], "target_type", lookup(local.tg_defaults, "target_type"))
    slow_start = lookup(var.target_groups[count.index], "slow_start", lookup(local.tg_defaults, "slow_start"))

    dynamic "stickiness" {
        for_each = var.stickiness

        content {
            type            = "lb_cookie"
            cookie_duration = lookup(var.stickiness.value, "cookie_duration", lookup(local.tg_defaults, "cookie_duration"))
            enabled         = lookup(var.stickiness.value, "stickiness_enabled", lookup(local.tg_defaults, "stickiness_enabled"))
        }
    }

    dynamic "health_check" {
        for_each = var.health_check

        content {
            interval            = lookup(var.health_check.value, "health_check_interval", lookup(local.tg_defaults, "health_check_interval"))
            path                = lookup(var.health_check.value, "health_check_path", lookup(local.tg_defaults, "health_check_path"))
            port                = lookup(var.health_check.value, "health_check_port", lookup(local.tg_defaults, "health_check_port"))
            protocol            = lookup(var.health_check.value, "health_check_protocol", lookup(var.target_groups[count.index], "protocol"))
            timeout             = lookup(var.health_check.value, "health_check_timeout", lookup(local.tg_defaults, "health_check_timeout"))    
            healthy_threshold   = lookup(var.health_check.value, "health_check_healthy_threshold", lookup(local.tg_defaults, "health_check_healthy_threshold"))
            unhealthy_threshold = lookup(var.health_check.value, "health_check_unhealthy_threshold", lookup(local.tg_defaults, "health_check_unhealthy_threshold"))
            matcher             = lookup(var.health_check.value, "health_check_matcher", lookup(local.tg_defaults, "health_check_matcher"))
        }
    }

    tags = var.tg_tags

    depends_on = [aws_lb.tf_alb]

    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_lb_listener" "frontend_http_tcp" {
    count             = var.create_lb ? length(var.http_tcp_listeners) : 0
    load_balancer_arn = aws_lb.tf_alb.arn
    port              = lookup(var.http_tcp_listeners[count.index], "port")
    protocol          = lookup(var.http_tcp_listeners[count.index], "protocol")

    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.tf_target_group.*.id[lookup(var.http_tcp_listeners[count.index], "target_group_index", 0)]
    }
}

resource "aws_lb_listener" "frontend_https" {
    count             = var.create_lb ? length(var.https_listeners) : 0 
    load_balancer_arn = aws_lb.tf_alb.*.arn
    port              = lookup(var.https_listeners[count.index], "port")
    protocol          = lookup(var.https_listeners[count.index], "protocol")
    ssl_policy        = lookup(var.https_listeners[count.index], "ssl_policy")
    certificate_arn   = lookup(var.https_listeners[count.index], "certificate_arn")

    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.tf_target_group.*.id[lookup(var.https_listeners[count.index], "target_group_index", 0)]
    }
}

resource "aws_lb_listener" "redirect_http_to_https" {
    count             = var.create_lb ? length(var.https_listeners) : 0
    load_balancer_arn = aws_lb.tf_alb.*.arn
    port              = "80"
    protocol          = "HTTP"

    default_action {
        type = "redirect"
        redirect {
            port = lookup(var.https_listeners[count.index], "port")
            protocol = lookup(var.https_listeners[count.index], "protocol")
            status_code = "HTTP_301"
        }
    }
}