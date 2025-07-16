output "mongodb_secret_arn" {
  description = "ARN of the stored MongoDB secret"
  value       = aws_secretsmanager_secret.mongodb_uri.arn
}
