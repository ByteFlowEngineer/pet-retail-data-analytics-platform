module "s3" {
  source             = "../../modules/s3"
  bucket_name        = "${var.project_short_name}-${var.environment}-data-lakehouse"
  environment        = var.environment
  owner              = var.owner
  project_short_name = var.project_short_name
}

module "iam" {
  source             = "../../modules/iam"
  environment        = var.environment
  owner              = var.owner
  s3_bucket_arn      = module.s3.bucket_arn
  project_short_name = var.project_short_name
}

module "glue_catalog" {

  source             = "../../modules/glue_catalog"
  environment        = var.environment
  owner              = var.owner
  project_short_name = var.project_short_name
  bucket_name        = module.s3.bucket_name

}


module "glue_jobs" {
  source             = "../../modules/glue_jobs"
  bucket_name        = module.s3.bucket_name
  environment        = var.environment
  job_name           = "${var.project_short_name}-${var.environment}-init-metadata"
  project_short_name = var.project_short_name
  glue_role_arn      = module.iam.glue_role_arn
  script_s3_location = "s3://${module.s3.bucket_name}/scripts/foundation/init_metadata.py"
  metadata_database  = module.glue_catalog.glue_catalog_metadata_name
  owner              = var.owner
  job_description    = "Glue ETL Job"
}
