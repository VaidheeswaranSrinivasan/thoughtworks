output "alb_arn" {
    value = aws_lb.tf_alb.arn
}

output "alb_dns_name" {
    value = aws_lb.tf_alb.dns_name
}

output "tg_arn" {
    value = aws_lb_target_group.tf_target_group.*.arn
}

output "tg_name" {
    value = aws_lb_target_group.tf_target_group.*.name
}