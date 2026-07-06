variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "owner" {
  description = "Project implemented by"
  type        = string
}

variable "project_short_name" {
  description = "Project short name"
  type        = string

}

variable "s3_bucket_arn" {
  description = "Bucket ARN"
  type        = string
}
