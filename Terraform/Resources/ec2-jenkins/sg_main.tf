resource "aws_security_group" "tf_sg" {
    name        = var.sg_name
    vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id[0]
    tags        = merge({"Name" = var.sg_name}, var.sg_tags)
}

resource "aws_security_group_rule" "tf_sg_ingress_rule" {
    count             = length(var.sg_rules)
    security_group_id = aws_security_group.tf_sg.id
    type              = lookup(var.sg_rules[count.index], "type")
    description       = lookup(var.sg_rules[count.index], "description")
    from_port         = lookup(var.sg_rules[count.index], "from_port")
    to_port           = lookup(var.sg_rules[count.index], "to_port")
    protocol          = lookup(var.sg_rules[count.index], "protocol")
    cidr_blocks       = lookup(var.sg_rules[count.index], "cidr_blocks")
}