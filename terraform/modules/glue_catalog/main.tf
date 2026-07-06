locals {

  common_tags = {
    Project     = var.project_short_name
    Environment = var.environment
    Owner       = var.owner
    ManagedBy   = "Terraform"
  }
}

resource "aws_glue_catalog_database" "catalog_database" {
  name        = "${var.project_short_name}_${var.environment}_catalog_db"
  description = "Glue Catalog database for the Pet Retail Data Analytics Platform."
  #location_uri = "s3://${var.bucket_name}/catalog/"

  tags = merge(
    local.common_tags,
    {
      Service = "Glue_catalog"
  })
}

resource "aws_glue_catalog_database" "metadata_catalog_database" {
  name        = "${var.project_short_name}_${var.environment}_metadata_db"
  description = "Glue Catalog database for the Pet Retail Data Analytics Platform."
  #location_uri = "s3://${var.bucket_name}/metadata/"

  tags = merge(
    local.common_tags,
    {
      Service = "Glue_catalog"
  })
}

