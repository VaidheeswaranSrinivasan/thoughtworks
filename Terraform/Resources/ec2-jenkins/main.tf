data "template_file" "user_data" {
    template = file(var.user_data)
}

module "ec2_instance" {
    source                      = "../../Modules/ec2"
    name                        = var.name
    instance_count              = var.instance_count
    ami                         = var.ami
    tenancy                     = var.tenancy
    instance_type               = var.instance_type
    subnet_id                   = data.aws_subnet_ids.subnet_ids.ids
    associate_public_ip_address = var.associate_public_ip_address
    key_name                    = var.key_name
    disable_api_termination     = var.disable_api_termination
    monitoring                  = var.monitoring
    vpc_security_group_ids      = concat([aws_security_group.tf_sg.id], [data.terraform_remote_state.vpc.outputs.vpc_default_security_group_id[0]])
    user_data                   = data.template_file.user_data.rendered
    iam_instance_profile        = var.iam_instance_profile
    root_block_device           = var.root_block_device
    ebs_block_device            = var.ebs_block_device
    volume_tags                 = var.volume_tags
    tags                        = var.tags
}

output "id" {
    value = module.ec2_instance.instance_id
}

output "public_ip" {
    value = module.ec2_instance.instance_public_ip
}

output "public_dns" {
    value = module.ec2_instance.instance_public_dns
}

output "private_ip" {
    value = module.ec2_instance.instance_private_ip
}

output "subnet_id" {
    value = module.ec2_instance.instance_subnet
}