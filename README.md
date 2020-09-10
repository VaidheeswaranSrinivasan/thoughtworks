# thoughtworks

The repository holds the code for deploying the mediawiki application

Required softwares to be installed in the local machine
1.) Packer
2.) Terraform

Please follow the below steps for deploying the mediawiki application.
1.) Set the AWS access and secret keys as env variables in the local machine.
2.) Run "packer build <filename>" from the local machine to create a golden ami which will be used for the application server.
3.) Run "terraform init & terraform apply" for provisionig the resources.
4.) Create the Systems manager document of type command for deploying the application to the target servers.
5.) Deploy the application via ansible role to the target server with a job in jenkins.

AMI creation - Packer
Infra provisioning - Terraform
Deployment - Ansible
Orchestration Tool - Jenkins and Systems Manager