#!/bin/bash -eux

# Upgrade server to the latest version
sudo yum -y upgrade

# Install Ansible repository.
sudo yum -y install wget
wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo rpm -ivh epel-release-latest*

# Install Ansible.
sudo yum -y install ansible

# Install Python pip
sudo yum -y install python-pip
sudo pip install --upgrade pip
sudo pip install netaddr
sudo pip install boto3
sudo pip install pymysql

# Installing Git
sudo yum -y install git

# Installing and configuring PHP 7.x
sudo yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y
sudo yum-config-manager --enable remi-php72

# Install SSM Agent
sudo yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm