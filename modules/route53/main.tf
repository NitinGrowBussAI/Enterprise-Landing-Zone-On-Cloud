resource "aws_route53_zone" "this" {

  name = var.domain_name

}

resource "aws_route53_record" "cloudfront" {

  zone_id = aws_route53_zone.this.zone_id

  name = var.domain_name

  type = "A"

  alias {

    name = var.cloudfront_domain

    zone_id = var.cloudfront_zone_id

    evaluate_target_health = false

  }

}

