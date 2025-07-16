variable "project_name" {
  description = "Name prefix for all resources"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR for the public subnet"
  type        = string
}

variable "private_subnet_cidr" {
  description = "CIDR for the private subnet"
  type        = string
}

variable "availability_zone" {
  description = "Availability zone to deploy subnets into"
  type        = string
}

variable "enable_nat" {
  description = "Enable NAT Gateway for private subnet egress"
  type        = bool
}
