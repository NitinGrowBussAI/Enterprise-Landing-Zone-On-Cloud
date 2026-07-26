output "environment" {
  value = var.environment
}
output "region" {
  value = var.aws_region
}
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

output "alb_dns_name" {

  value = module.alb.alb_dns_name

}
output "database_endpoint" {

  value = module.rds.db_endpoint

}

output "database_port" {

  value = module.rds.db_port

}

output "s3_bucket" {

  value = module.s3.bucket_name

}

output "cloudfront_url" {

  value = module.cloudfront.distribution_domain

}