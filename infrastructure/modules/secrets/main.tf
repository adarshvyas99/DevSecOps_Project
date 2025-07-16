resource "aws_secretsmanager_secret" "mongodb_uri" {
  name        = "${var.project_name}/mongodb-uri"
  description = "MongoDB Atlas URI for ${var.project_name} project"
}

resource "aws_secretsmanager_secret_version" "mongodb_uri_version" {
  secret_id     = aws_secretsmanager_secret.mongodb_uri.id
  secret_string = var.mongodb_connection_uri
}
