variable "instance_count" {
    description = "Number of instances to be created"
    type = string
    default = "1"
}

variable "ami" {
    description = "The AMI to be used to create the instance"
    type = string
    default = ""
}

variable "tenancy" {
    description = "The tenancy of the instance"
    type = string
    default = "default"
}

variable "instance_type" {
    description = "The type of the instance to be used"
    type = string
    default = ""
}

variable "subnet_id" {
    description = "The subnet in which the instance needs to be created"
    type = list
}

variable "associate_public_ip_address" {
    description = "To determine whether to launch public IP's for the instance"
    type = bool
    default = false
}

variable "key_name" {
    description = "The key to be used to connect to the instance"
    type = string
    default = ""
}

variable "disable_api_termination" {
    description = "Determines the EC2 termination protection"
    type = bool
    default = false
}

variable "monitoring" {
    description = "Determines whether the EC2 needs to have detailed monitoring"
    type = bool
    default = false
}

variable "vpc_security_group_ids" {
    description = "List of security groups for the instance"
    type = list(string)
}

variable "source_dest_check" {
    description = "Used to the enable the source/dest checks for the instance"
    type = bool
    default = true
}

variable "user_data" {
    description = "The user data needs to be passed into the instance during launch"
    type = string
    default = ""
}

variable "iam_instance_profile" {
    description = "The IAM role to be passed to the instance during launch"
    type = string
    default = ""
}

variable "name" {
    description = "The name of the instance"
    type = string
    default = ""
}

variable "sg_name" {
    description = "The name of the security group"
    type = string
    default = ""
}

variable "sg_rules" {
    description = "The list of security group ingress rules"
    type = list
    default = []
}

variable "root_block_device" {
    description = "The root block device for the instance"
    type = list(map(string))
    default = []
}

variable "ebs_block_device" {
    description = "The list of ebs block devices for the instance"
    type = list(map(string))
    default = []
}

variable "volume_tags" {
    description = "The tags to be used for volumes"
    type = map
    default = {}
}

variable "tags" {
    description = "The map of tags for the instances"
    type = map
    default = {}
}