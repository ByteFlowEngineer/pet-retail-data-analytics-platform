output "bucket_name" {
  value = module.s3.bucket_name
}

output "bucket_arn" {
  value = module.s3.bucket_arn
}

output "glue_role_arn" {
  value = module.iam.glue_role_arn
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
