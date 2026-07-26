resource "aws_cloudfront_origin_access_control" "this" {

  name = "${var.project_name}-${var.environment}"

  description = "Origin Access Control"

  origin_access_control_origin_type = "s3"

  signing_behavior = "always"

  signing_protocol = "sigv4"

}
resource "aws_cloudfront_distribution" "this" {

  enabled = true

  is_ipv6_enabled = true

  default_root_object = "index.html"

  price_class = "PriceClass_100"

  origin {

    domain_name = var.bucket_domain_name

    origin_id = "s3Origin"

    origin_access_control_id = aws_cloudfront_origin_access_control.this.id

  }

  default_cache_behavior {

    allowed_methods = [
      "GET",
      "HEAD"
    ]

    cached_methods = [
      "GET",
      "HEAD"
    ]

    target_origin_id = "s3Origin"

    viewer_protocol_policy = "redirect-to-https"

    compress = true

    cache_policy_id = "658327ea-f89d-4fab-a63d-7e88639e58f6"

  }

  restrictions {

    geo_restriction {

      restriction_type = "none"

    }

  }

  viewer_certificate {

    acm_certificate_arn = var.certificate_arn

    ssl_support_method = "sni-only"

    minimum_protocol_version = "TLSv1.2_2021"

}

}
