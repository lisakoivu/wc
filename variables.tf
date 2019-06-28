variable "aws_region" {
  type        = string
  description = "Default region for object creation."
  default     = "us-east-1"
}
variable "server_name" {
  type        = string
  description = "Value of the name tag for this server."
  default     = "nginx server"
}

variable instance_type {
  type        = string
  description = "Instance type to launch."
  default     = "t2.micro"
}

variable ingress_22_cidr_blocks {
  type        = list
  description = "Ingress allowed on port 22 from these CIDRs."
}
