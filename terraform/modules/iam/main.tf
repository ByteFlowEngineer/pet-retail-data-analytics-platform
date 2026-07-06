locals {
  common_tags = {
    Project     = var.project_short_name
    Environment = var.environment
    Owner       = var.owner
    ManagedBy   = "Terraform"
  }
}

###############################################
# Custom S3 Access Policy
###############################################

resource "aws_iam_policy" "glue_s3_access_policy" {

  name        = "${var.project_short_name}-${var.environment}-glue-s3-access-policy"
  description = "Allows Glue to access the Pet Retail Data Lake."
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:*"
        ]
        Resource = [
          var.s3_bucket_arn,
          "${var.s3_bucket_arn}/*"
        ]
      }
    ]
  })
}

###############################################
# Glue IAM Role
###############################################

resource "aws_iam_role" "glue_role" {
  name = "${var.project_short_name}-${var.environment}-glue-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "sts:AssumeRole"
        Principal = {
          Service = "glue.amazonaws.com"
        }
      }
    ]
  })
  tags = merge(
    local.common_tags,
    {
      Service = "Glue"
  })
}

###############################################
# Attach AWS Managed Glue Policy
###############################################

resource "aws_iam_role_policy_attachment" "glue_service_role_attachment" {
  role       = aws_iam_role.glue_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}

###############################################
# Attach Custom S3 Policy
###############################################

resource "aws_iam_role_policy_attachment" "glue_s3_access_attachment" {
  role       = aws_iam_role.glue_role.name
  policy_arn = aws_iam_policy.glue_s3_access_policy.arn
}
