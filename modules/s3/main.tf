resource "aws_s3_bucket" "this" {

  bucket = "${var.project_name}-${var.environment}-assets"

  force_destroy = false

  tags = {

    Name = "${var.project_name}-assets"

  }

}

resource "aws_s3_bucket_versioning" "this" {

  bucket = aws_s3_bucket.this.id

  versioning_configuration {

    status = "Enabled"

  }

}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {

  bucket = aws_s3_bucket.this.id

  rule {

    apply_server_side_encryption_by_default {

      sse_algorithm = "AES256"

    }

  }

}

resource "aws_s3_bucket_public_access_block" "this" {

  bucket = aws_s3_bucket.this.id

  block_public_acls = true

  block_public_policy = true

  ignore_public_acls = true

  restrict_public_buckets = true

}

resource "aws_s3_bucket_ownership_controls" "this" {

  bucket = aws_s3_bucket.this.id

  rule {

    object_ownership = "BucketOwnerEnforced"

  }

}

resource "aws_s3_bucket_lifecycle_configuration" "this" {

  bucket = aws_s3_bucket.this.id

  rule {

    id = "cleanup"

    status = "Enabled"

    filter {}

    transition {

      days = 30

      storage_class = "STANDARD_IA"

    }

    transition {

      days = 90

      storage_class = "GLACIER"

    }

    expiration {

      days = 365

    }

  }

}

