provider "aws" {
  version = "~> 2.0"
  region  = "${var.aws_region}"
}

terraform {
  required_version = "~>0.12"
}
#-----------------------------------------------------------------------
# Create the VPC from a module
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true

  tags = {
    Terraform = "true"
  }
}
#-----------------------------------------------------------------------
# Create the two required security groups

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
  ingress_cidr_blocks = "${var.ingress_22_cidr_blocks}"
}
#-----------------------------------------------------------------------
# Look up the most recent Amazon Linux ami

data "aws_ami" "AmazonLinux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn-ami-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["amazon"] # Canonical
}

#-----------------------------------------------------------------------
# Finally, create the instance and reference local userdata

resource "aws_instance" "web" {
  ami = "${data.aws_ami.AmazonLinux.id}"

  instance_type               = "${var.instance_type}"
  associate_public_ip_address = true
  monitoring                  = true
  subnet_id                   = element("${module.vpc.public_subnets}", 1)
  vpc_security_group_ids      = ["${module.http_80_security_group.this_security_group_id}", "${module.ssh_22_security_group.this_security_group_id}"]
  user_data                   = file("${path.module}/userdata.txt")
  tags = { Name = "${var.server_name}"
  }
}

