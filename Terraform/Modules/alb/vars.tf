variable "create_lb" {
    description = "Determines whether to create the load balancer or not"
    type = bool
    default = true
}

variable "name" {
    description = "The name of the load balancer"
    type = string
    default = ""
}

variable "is_load_balancer_internal" {
    description = "To determine whether the load balancer in internal or external"
    type = bool
    default = false
}

variable "security_groups" {
    description = "The list of SG's need to be attached to load balancer"
    type = list
    default = []
}

variable "subnets" {
    description = "The list of subnets in which the load balancer needs to be created"
    type = list
    default = []
}

variable "idle_timeout" {
    description = "The idle timeout for the load balancer"
    type = string
    default = 60
}

variable "enable_deletion_protection" {
    description = "To determine whether the load balancer can be deleted from the console"
    type = bool
    default = false
}

variable "enable_cross_zone_load_balancing" {
    description = "To determine whether the load balancer supports cross zone"
    type = bool
    default = false
}

variable "enable_http2" {
    description = "To determine whether HTTP/2 is suppoerted for load balancer"
    type = bool
    default = true
}

variable "ip_address_type" {
    description = "To express which IP address the load balancer supports (ipv4 or dualstack)"
    type = string
    default = "ipv4"
}

#variable "access_logs" {
#    description = "The access logs for the load balancer"
#    type = map(string)
#    default = []
#}

variable "subnet_mapping" {
    description = "The list of subnets for the load balancer"
    type = list(map(string))
    default = []
}

variable "lb_tags" {
    description = "The tags for the load balancer"
    type = map
    default = {}
}

variable "lb_create_timeout" {
    description = "The creation timeout for the load balancer"
    type = string
    default = "10m"
}

variable "lb_update_timeout" {
    description = "The update timeout for the load balancer"
    type = string
    default = "10m"
}

variable "lb_delete_timeout" {
    description = "The deletion timeout for the load balancer"
    type = string
    default = "10m"
}

variable "target_groups" {
    description = "The target groups for the load balancer"
    type = list
    default = []
}

variable "vpc_id" {
    description = "The VPC in which the load balancer needs to be created"
    type = string
    default = ""
}

variable "target_group_defaults" {
    description = "The defaults for the target group. It should be a map"
    type = map
    default = {}
}

variable "stickiness" {
    description = "The stickiness value for the load balancer"
    type = map(string)
    default = {}
}

variable "health_check" {
    description = "The health check associated with the load balancer"
    type = map(string)
    default = {}
}

variable "tg_tags" {
    description = "The tags need to be associated with TG"
    type = map
    default = {}
}

variable "http_tcp_listeners" {
    description = "The list of HTTP listeners for the load balancer"
    type = list
    default = []
}

variable "https_listeners" {
    description = "The list of HTTPS listeners for the lod balancer"
    type = list
    default = []
}

