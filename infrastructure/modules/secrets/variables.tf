variable "project_name" {
  description = "Project name for namespacing secrets"
  type        = string
}

variable "mongodb_connection_uri" {
  description = "MongoDB connection string from Atlas"
  type        = string
  sensitive   = true
}
