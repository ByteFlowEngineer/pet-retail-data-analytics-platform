variable "project_short_name" {
  description = "Project short name"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "glue_job_arn" {
  description = "Glue Job arn"
  type        = string
}

variable "bucket_arn" {
  description = "S3 Data Lake bucket arn"
  type        = string
}

variable "github_owner" {
  description = "GitHub organization or username"
  type        = string
}

variable "github_repository" {
  description = "GitHub repository name"
  type        = string
}

variable "owner" {
  description = "Project implemented by"
  type        = string
}
