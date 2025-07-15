variable "project_name" {
  type        = string
  description = "Project name prefix for tags"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID to attach SGs to"
}
