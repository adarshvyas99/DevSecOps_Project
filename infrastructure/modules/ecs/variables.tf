variable "project_name" {
  type = string
}

variable "container_image" {
  description = "ECR image URL with tag"
  type        = string
}

variable "mongodb_secret_arn" {
  description = "ARN of the MongoDB secret"
  type        = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "ecs_sg_id" {
  type = string
}

variable "alb_target_group_arn" {
  type = string
}
