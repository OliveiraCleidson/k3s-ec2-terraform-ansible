terraform {
  required_version = ">= 1.7.2"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.44.0"
    }
  }
}

# The credentials are stored in the environment variables
# or in ~/.aws/credentials

provider "aws" {
  region = var.aws_region
  profile = var.aws_profile
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.7.1"

  name = var.vpc_name
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a"]
  private_subnets = ["10.0.1.0/24"]
  public_subnets  = ["10.0.101.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true
  enable_vpn_gateway = false

  tags = local.common_tags
}

module "ecr" {
  source = "./modules/compute/ecr"

  common_tags = local.common_tags
  ecr_name = "${var.project_name}_k3s_repo"
}

module "ssh_key" {
  source = "./modules/keys/ssh"

  ssh_key_name = var.aws_ssh_key_name
  common_tags = local.common_tags
}

module "ec2" {
  source = "./modules/compute/ec2"
  vpc_id = module.vpc.vpc_id
  common_tags = local.common_tags
  project_name = var.project_name
  environment = var.environment
  public_subnet_id = module.vpc.public_subnets[0]
  private_subnet_id = module.vpc.private_subnets[0]
  aws_instance_ssh_key = var.aws_ssh_key_name
  
  depends_on = [
    module.vpc,
    module.ssh_key
  ]
}