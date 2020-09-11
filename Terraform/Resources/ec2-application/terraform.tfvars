instance_count              = 2
name                        = "app-server"
ami                         = "ami-0f0626acb25ad9da1"  # Golden AMI created from packer
instance_type               = "t2.micro"
subnet_filter               = "*public_1*"
associate_public_ip_address = true
key_name                    = "london"
iam_instance_profile        = "EC2_Instance_Role"
user_data                   = "user_data.sh"

root_block_device = [
    {
        volume_type           = "gp2"
        volume_size           = 10
        delete_on_termination = "true"
        encypted              = "false"
    }
]

volume_tags = {
    "Name"      = "ebs_application"
    "encrypted" = "false"
}

tags = {
    "type" = "ec2-application-instance"
    "description" = "EC2 instance for Application"
}

sg_name = "app_sg"

sg_tags = {
    "descrition" = "The security group that allows HTTP port to access the application from anywhere"
}

sg_rules = [
    {
        type        = "ingress" 
        description = "Allows SSH access from anywhere"
        from_port   = "22"
        to_port     = "22"
        protocol    = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    },
    {
        type        = "ingress" 
        description = "Allows HTTP access from anywhere"
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