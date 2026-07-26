output "db_endpoint" {

  value = aws_db_instance.postgres.address

}

output "db_port" {

  value = aws_db_instance.postgres.port

}

output "db_identifier" {

  value = aws_db_instance.postgres.id

}