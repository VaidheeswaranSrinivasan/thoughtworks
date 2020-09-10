locals {
    target_group_configs = {
        deregistration_delay = 120
        target_type = "instance"
        slow_start = 0
        cookie_duration = 86400
        stickiness_enabled = true
        health_check_interval = 10
        health_check_path = "/"
        health_check_port = "traffic-port"
        health_check_timeout = 5
        health_check_healthy_threshold = 3
        health_check_unhealthy_threshold = 3 
        health_check_matcher = "200-299"
    }
    
    tg_defaults = merge(local.target_group_configs, var.target_group_defaults)
}

