module "vpc" {

  source = "./modules/vpc"

  project_name = var.project_name
  environment  = var.environment
  vpc_cidr     = var.vpc_cidr

}
module "iam" {

  source = "./modules/iam"

  project_name = var.project_name

  environment = var.environment

}

module "security_groups" {

  source = "./modules/security-groups"

  vpc_id = module.vpc.vpc_id

  project_name = var.project_name

  environment = var.environment

}

module "alb" {

  source = "./modules/alb"

  project_name = var.project_name

  environment = var.environment

  vpc_id = module.vpc.vpc_id

  public_subnets = module.vpc.public_subnets

  alb_security_group = module.security_groups.alb_sg

}

module "launch_template" {

  source = "./modules/launch-template"

  project_name = var.project_name
  environment  = var.environment

  ami_id = var.ami_id

  instance_profile = module.iam.instance_profile

  ec2_security_group = module.security_groups.ec2_sg

  private_subnets = module.vpc.private_subnets

}

module "autoscaling" {

  source = "./modules/autoscaling"

  project_name = var.project_name
  environment = var.environment

  launch_template_id = module.launch_template.launch_template_id

  launch_template_version = module.launch_template.latest_version

  private_subnets = module.vpc.private_subnets

  target_group_arn = module.alb.target_group_arn

}
module "secrets_manager" {

  source = "./modules/secrets-manager"

  project_name = var.project_name

  environment = var.environment

  db_username = var.db_username
  

}

module "rds" {

  source = "./modules/rds"

  project_name = var.project_name

  environment = var.environment

  private_subnets = module.vpc.private_subnets

  rds_security_group = module.security_groups.rds_sg

  db_username = var.db_username

  db_password = module.secrets_manager.db_password

}

module "s3" {

  source = "./modules/s3"

  project_name = var.project_name

  environment = var.environment

}

module "cloudfront" {

  source = "./modules/cloudfront"

  project_name = var.project_name

  environment = var.environment

  bucket_name = module.s3.bucket_name

  bucket_domain_name = module.s3.bucket_domain_name

  certificate_arn = module.acm.certificate_arn

    aliases = [

        var.domain_name

    ]

}

module "waf" {

  source = "./modules/waf"

  project_name = var.project_name

  environment = var.environment

  cloudfront_distribution_arn = module.cloudfront.distribution_arn

}

module "route53" {

    source = "./modules/route53"

    domain_name = var.domain_name

}

module "acm" {

    source = "./modules/acm"

    domain_name = var.domain_name

    hosted_zone_id = module.route53.hosted_zone_id


}


module "cloudwatch" {

    source = "./modules/cloudwatch"

    project_name = var.project_name

    environment = var.environment

    asg_name = module.autoscaling.asg_name

    alb_arn_suffix = module.alb.alb_arn_suffix

    db_identifier = module.rds.db_identifier

    notification_email = var.notification_email

}