output "instance_id" {
    value = aws_instance.tf_instance.*.id
}

output "instance_public_ip" {
    value = aws_instance.tf_instance.*.public_ip
}

output "instance_public_dns" {
    value = aws_instance.tf_instance.*.public_dns
}

output "instance_private_ip" {
    value = aws_instance.tf_instance.*.private_ip
}

output "instance_subnet" {
    value = aws_instance.tf_instance.*.subnet_id
}