variable "aws_region" {
  type = string
}

variable "aws_profile" {
  description = "AWS CLI profile used for local development"
  type        = string
  default     = null
}

variable "environment" {
  type = string
}

variable "project_name" {
  type = string
}

variable "project_short_name" {
  type = string
}

variable "owner" {
  type = string
}
