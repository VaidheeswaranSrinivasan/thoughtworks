instance_count              = 1
name                        = "jenkins-server"
ami                         = "ami-014ec3973fd627c70"
instance_type               = "t2.micro"
subnet_filter               = "*public_1*"
associate_public_ip_address = true
key_name                    = "london"
iam_instance_profile        = "JenkinsRole"
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
    "Name"      = "ebs_jenkins"
    "encrypted" = "false"
}

tags = {
    "type" = "ec2-jenkins-ci"
    "description" = "EC2 instance for Jenkins CI"
}

sg_name = "jenkins_sg"

sg_tags = {
    "descrition" = "The security group that allows Jenkins port access from anywhere"
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
        description = "Allows Jenkins access from anywhere"
        from_port   = "8080"
        to_port     = "8080"
        protocol    = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }
]