output "glue_catalog_name" {
  value = aws_glue_catalog_database.catalog_database.name
}

output "glue_catalog_arn" {
  value = aws_glue_catalog_database.catalog_database.arn
}

output "glue_catalog_metadata_name" {
  value = aws_glue_catalog_database.metadata_catalog_database.name
}

output "glue_catalog_metadata_arn" {
  value = aws_glue_catalog_database.metadata_catalog_database.arn
}
