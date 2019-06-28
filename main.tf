provider "aws" {
  version = "~> 2.0"
  region  = "us-east-1"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform = "true"
    #   Environment = "dev"
  }
}

module "http_80_security_group" {
  source  = "terraform-aws-modules/security-group/aws//modules/http-80"
  version = "~> 3.0"

  name                = "http80-sg"
  vpc_id              = module.vpc.vpc_id
  ingress_cidr_blocks = ["0.0.0.0/0"]
}

module "ssh_22_security_group" {
  source  = "terraform-aws-modules/security-group/aws//modules/ssh"
  version = "~> 3.0"

  name                = "ssh-sg"
  vpc_id              = module.vpc.vpc_id
  ingress_cidr_blocks = ["192.0.2.0/32", "192.0.2.128/32", "198.51.100.192/32", "97.101.177.46/32"]
}


