output "vpc_id" {
  description = "The VPC id"
  value       = module.vpc.vpc_id
}

output "http_80_sg_id" {
  description = "The security group that allows all traffic to port 80."
  value       = module.http_80_security_group.this_security_group_id
}
output "ssh_22_sg_id" {
  description = "The security group that allows SSH traffic to 22 from specified IP addresses."
  value       = module.ssh_22_security_group.this_security_group_id
}

output "instance_ip_addr" {
  value       = "${aws_instance.web.public_ip}"
  description = "The public IP address of the main server instance."
}

output "public_subnet_ids" {
  value = "${module.vpc.private_subnets}"
}
