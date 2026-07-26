resource "aws_wafv2_web_acl" "this" {

  name  = "${var.project_name}-${var.environment}-waf"

  scope = "CLOUDFRONT"

  default_action {
    allow {}
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "${var.project_name}-waf"
    sampled_requests_enabled   = true
  }

}

resource "aws_wafv2_web_acl" "managed" {

  name  = "${var.project_name}-${var.environment}-managed"

  scope = "CLOUDFRONT"

  default_action {
    allow {}
  }

  rule {

    name = "AWSManagedRulesCommonRuleSet"

    priority = 1

    override_action {
      none {}
    }

    statement {

      managed_rule_group_statement {

        vendor_name = "AWS"

        name = "AWSManagedRulesCommonRuleSet"

      }

    }

    visibility_config {

      cloudwatch_metrics_enabled = true

      metric_name = "CommonRules"

      sampled_requests_enabled = true

    }

  }


rule {

  name = "RateLimit"

  priority = 10

  action {

    block {}

  }

  statement {

    rate_based_statement {

      limit = 1000

      aggregate_key_type = "IP"

    }

  }

  visibility_config {

    cloudwatch_metrics_enabled = true

    metric_name = "RateLimit"

    sampled_requests_enabled = true

  }

}

rule {

  name = "SQLInjection"

  priority = 20

  override_action {

    none {}

  }

  statement {

    managed_rule_group_statement {

      vendor_name = "AWS"

      name = "AWSManagedRulesSQLiRuleSet"

    }

  }

  visibility_config {

    cloudwatch_metrics_enabled = true

    metric_name = "SQLi"

    sampled_requests_enabled = true

  }

}

rule {

  name = "KnownBadInputs"

  priority = 30

  override_action {

    none {}

  }

  statement {

    managed_rule_group_statement {

      vendor_name = "AWS"

      name = "AWSManagedRulesKnownBadInputsRuleSet"

    }

  }

  visibility_config {

    cloudwatch_metrics_enabled = true

    metric_name = "BadInputs"

    sampled_requests_enabled = true

  }

}

rule {

  name = "LinuxRules"

  priority = 40

  override_action {

    none {}

  }

  statement {

    managed_rule_group_statement {

      vendor_name = "AWS"

      name = "AWSManagedRulesLinuxRuleSet"

    }

  }

  visibility_config {

    cloudwatch_metrics_enabled = true

    metric_name = "Linux"

    sampled_requests_enabled = true

  }

}
  

  visibility_config {

    cloudwatch_metrics_enabled = true

    metric_name = "MainACL"

    sampled_requests_enabled = true

  }

}

resource "aws_wafv2_web_acl_association" "cloudfront" {

  resource_arn = var.cloudfront_distribution_arn

  web_acl_arn = aws_wafv2_web_acl.this.arn

}