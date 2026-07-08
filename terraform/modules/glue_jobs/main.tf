locals {
  common_tags = {
    Project     = var.project_short_name
    Environment = var.environment
    Owner       = var.owner
    ManagedBy   = "Terraform"
  }
}

resource "aws_glue_job" "this" {
  name              = var.job_name
  description       = var.job_description
  role_arn          = var.glue_role_arn
  glue_version      = "5.0"
  max_retries       = 0
  timeout           = 30
  number_of_workers = 2
  worker_type       = "G.1X"
  execution_class   = "STANDARD"

  command {
    script_location = var.script_s3_location
    name            = "glueetl"
    python_version  = "3"
  }

  notification_property {
    notify_delay_after = 3 # delay in minutes
  }

  default_arguments = {
    "--job-language"                     = "python"
    "--enable-glue-datacatalog"          = "true"
    "--datalake-formats"                 = "delta"
    "--enable-continuous-cloudwatch-log" = "true"
    "--enable-continuous-log-filter"     = "true"
    "--enable-metrics"                   = ""
    "--enable-auto-scaling"              = "true"
    "--bucket_name"                      = var.bucket_name
    "--metadata_database"                = var.metadata_database
  }

  execution_property {
    max_concurrent_runs = 1
  }

  tags = local.common_tags
}


