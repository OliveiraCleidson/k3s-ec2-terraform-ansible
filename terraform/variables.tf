# The AWS Region used by the provider
variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "aws_profile" {
  type    = string
  default = "default"
}

variable "project_name" {
  type    = string
  default = "k3s"
}

variable "environment" {
  type    = string
  default = "dev"
}

locals {
  common_tags = {
    Terraform   = "true"
    Environment = "dev"
    Project     = "k3s"
  }
}

variable "vpc_name" {
  type    = string
  default = "k3s-vpc"
}

variable "aws_ssh_key_name" {
  type    = string
  default = "k3s-keypair"
}
