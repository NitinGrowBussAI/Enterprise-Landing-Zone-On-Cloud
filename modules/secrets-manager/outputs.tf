output "db_password" {

  sensitive = true

  value = random_password.db.result

}

output "secret_arn" {

  value = aws_secretsmanager_secret.database.arn

}