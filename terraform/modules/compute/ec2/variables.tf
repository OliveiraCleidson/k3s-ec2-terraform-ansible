variable "aws_instance_ssh_key" {
  type = string
}

## Project Configurations
variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "common_tags" {
  type = map(string)
}

## Network Configurations
variable "vpc_id" {
  type = string
}

variable "private_subnet_id" {
  type = string
}

variable "public_subnet_id" {
  type = string
}

variable "bastion_config" {
  type = map(string)
  default = {
    instance_type = "t2.nano",
    ami = "ami-051f8a213df8bc089"
  }
}

variable "k3s_cluster_config" {
  type = map(string)
  default = {
    instance_type = "t2.micro",
    ami = "ami-051f8a213df8bc089"
  }
}

variable "k3s_worker_config" {
  type = map(string)
  default = {
    instance_type = "t2.micro",
    ami = "ami-051f8a213df8bc089"
  }
}

locals {
  sg_names = {
    K3sMaster = "${var.project_name}_k3s-master-sg",
    K3sWorker = "${var.project_name}_k3s-worker-sg",
    Bastion   = "${var.project_name}_bastion-sg"
  }
}