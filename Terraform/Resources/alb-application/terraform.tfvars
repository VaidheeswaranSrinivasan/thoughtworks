name                             = "app-alb"
subnet_filter                    = "*public_1*"
enable_cross_zone_load_balancing = true

lb_tags = {
    "Type" = "ALB"
}

target_groups = [
    {
        name     = "app-tg"
        port     = "80"
        protocol = "HTTP"
    }
]

http_tcp_listeners = [
    {
        port     = "80"
        protocol = "HTTP"
    }
]

tg_tags = {
    "Name"         = "tf-tg"
    "Type"         = "APP-TG"
}

sg_name = "app_alb_security_group"

sg_tags = {
    "description" = "The security group that allows HTTP access from anywhere for the ALB"
}

sg_rules = [
    {
        type        = "ingress"
        description = "Allow HTTP access from anywhere"
        from_port   = "80"
        to_port     = "80"
        protocol    = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    },
    {
        type        = "egress"
        description = "Allow all access"
        from_port   = "-1"
        to_port     = "-1"
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
] 