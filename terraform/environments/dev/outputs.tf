output "bucket_name" {
  value = module.s3.bucket_name
}

output "bucket_arn" {
  value = module.s3.bucket_arn
}

output "glue_role_arn" {
  value = module.iam.glue_role_arn
}
output "glue_role_name" {
  value = module.iam.glue_role_name
}

output "glue_job_name" {
  value = module.glue_jobs.glue_job_name
}

output "glue_job_arn" {
  value = module.glue_jobs.arn
}

output "glue_catalog_name" {
  value = module.glue_catalog.glue_catalog_name
}

output "glue_catalog_arn" {
  value = module.glue_catalog.glue_catalog_arn
}

output "glue_catalog_metadata_name" {
  value = module.glue_catalog.glue_catalog_metadata_name
}

output "glue_catalog_metadata_arn" {
  value = module.glue_catalog.glue_catalog_metadata_arn
}

output "github_actions_role_arn" {
  value = module.github_actions.github_actions_role_arn
}

output "github_actions_name_name" {
  value = module.github_actions.github_actions_role_name
}
