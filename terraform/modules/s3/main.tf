locals {

  common_tags = {
    Project     = var.project_short_name
    Environment = var.environment
    Owner       = var.owner
    ManagedBy   = "Terraform"
  }

  s3_folders = [
    # PRP datasets
    "landing/customers/",
    "landing/orders/",
    "landing/products/",
    "landing/stores/",
    "bronze/",
    "silver/",
    "gold/",
    "logs/",
    "temp/",
    "scripts/foundation/",
    "catalog/",
    "metadata/",
    "metadata/etl_job_control/",
    "metadata/etl_job_audit/"
  ]
}

resource "aws_s3_bucket" "data_lake" {
  bucket = var.bucket_name
  tags = merge(
    local.common_tags,
    {
      Name = var.bucket_name
  })
}

resource "aws_s3_object" "folders" {
  for_each = toset(local.s3_folders)
  bucket   = aws_s3_bucket.data_lake.id
  key      = each.value
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.data_lake.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_ownership_controls" "ownership" {
  bucket = aws_s3_bucket.data_lake.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.data_lake.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.data_lake.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

