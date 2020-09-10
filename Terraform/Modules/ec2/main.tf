resource "aws_instance" "tf_instance" {
    count                       = var.instance_count
    ami                         = var.ami
    tenancy                     = var.tenancy
    instance_type               = var.instance_type
    subnet_id                   = element(var.subnet_id, count.index)
    associate_public_ip_address = var.associate_public_ip_address
    key_name                    = var.key_name
    disable_api_termination     = var.disable_api_termination
    monitoring                  = var.monitoring
    vpc_security_group_ids      = var.vpc_security_group_ids
    source_dest_check           = var.source_dest_check
    user_data                   = var.user_data
    iam_instance_profile        = var.iam_instance_profile

    dynamic "root_block_device" {
        for_each = var.root_block_device
        content {
            volume_type           = lookup(root_block_device.value, "volume_type", null)
            volume_size           = lookup(root_block_device.value, "volume_size", null)
            delete_on_termination = lookup(root_block_device.value, "delete_on_termination", null)
            encrypted             = lookup(root_block_device.value, "encrypted", null)
        }
    }

    dynamic "ebs_block_device" {
        for_each = var.ebs_block_device
        content {
            device_name           = lookup(ebs_block_device.value, "device_name", null)
            volume_type           = lookup(ebs_block_device.value, "volume_type", null)
            volume_size           = lookup(ebs_block_device.value, "volume_size", null)
            delete_on_termination = lookup(ebs_block_device.value, "delete_on_termination", null)
            encrypted             = lookup(ebs_block_device.value, "encrypted", null)
        }
    }
    volume_tags                 = var.volume_tags
    tags                        = merge(map("Name", var.instance_count > 1 ? format("%s-%d", var.name, count.index+1) : var.name), var.tags)
}