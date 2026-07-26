resource "random_password" "db" {

  length = 20

  special = true

  override_special = "!@#$%&*"

}

resource "aws_secretsmanager_secret" "database" {

  name = "${var.project_name}-${var.environment}-database"

  recovery_window_in_days = 7

}
resource "aws_secretsmanager_secret_version" "database" {

  secret_id = aws_secretsmanager_secret.database.id

  secret_string = jsonencode({

    username = var.db_username

    password = random_password.db.result

    engine = "postgres"

    port = 5432

  })

}