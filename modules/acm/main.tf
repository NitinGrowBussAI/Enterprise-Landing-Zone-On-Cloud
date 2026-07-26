resource "aws_acm_certificate" "this" {

  provider = aws.us_east_1

  domain_name = var.domain_name

  validation_method = "DNS"

  lifecycle {

    create_before_destroy = true

  }

}

resource "aws_route53_record" "validation" {

  for_each = {

    for dvo in aws_acm_certificate.this.domain_validation_options :

    dvo.domain_name => {

      name = dvo.resource_record_name

      record = dvo.resource_record_value

      type = dvo.resource_record_type

    }

  }

  zone_id = var.hosted_zone_id

  name = each.value.name

  type = each.value.type

  records = [

    each.value.record

  ]

  ttl = 60

}

resource "aws_acm_certificate_validation" "this" {

  provider = aws.us_east_1

  certificate_arn = aws_acm_certificate.this.arn

  validation_record_fqdns = [

    for record in aws_route53_record.validation :

    record.fqdn

  ]

}

