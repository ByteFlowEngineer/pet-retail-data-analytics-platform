variable "bucket_name" {
  description = "S3 Data Lake bucket name"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "job_name" {
  description = "glue job name"
  type        = string
}

variable "project_short_name" {
  description = "Project hort name"
  type        = string
}

variable "glue_role_arn" {
  description = "Role ARN to run glue jobs"
  type        = string
}

variable "script_s3_location" {
  description = "glue script location"
  type        = string
}

variable "metadata_database" {
  description = "metadata database name to create tables"
  type        = string
}

variable "owner" {
  description = "Project implemented by"
  type        = string
}

variable "job_description" {
  type = string
}
