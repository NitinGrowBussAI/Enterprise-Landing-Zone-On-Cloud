resource "aws_db_subnet_group" "this" {

  name = "${var.project_name}-${var.environment}-db-subnet"

  subnet_ids = var.private_subnets

  tags = {

    Name = "${var.project_name}-db-subnet"

  }

}
resource "aws_db_parameter_group" "this" {

  name   = "${var.project_name}-${var.environment}"

  family = "postgres16"

}
resource "aws_db_instance" "postgres" {

  identifier = "${var.project_name}-${var.environment}"

  engine = "postgres"

  engine_version = "16.3"

  instance_class = var.instance_class

  allocated_storage = var.allocated_storage

  storage_type = "gp3"

  storage_encrypted = true

  username = var.db_username

  password = var.db_password

  db_subnet_group_name = aws_db_subnet_group.this.name

  vpc_security_group_ids = [
    var.rds_security_group
  ]

  parameter_group_name = aws_db_parameter_group.this.name

  multi_az = true

  publicly_accessible = false

  deletion_protection = true

  backup_retention_period = 7

  backup_window = "02:00-03:00"

  maintenance_window = "Sun:03:00-Sun:04:00"

  enabled_cloudwatch_logs_exports = [
    "postgresql"
  ]

  performance_insights_enabled = true

  skip_final_snapshot = false

  final_snapshot_identifier = "${var.project_name}-final-snapshot"

}
