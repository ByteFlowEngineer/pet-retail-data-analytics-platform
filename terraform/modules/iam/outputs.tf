output "glue_role_name" {
  value = aws_iam_role.glue_role.name
}

output "glue_role_arn" {
  value = aws_iam_role.glue_role.arn
}

output "glue_s3_access_policy_name" {
  value = aws_iam_policy.glue_s3_access_policy.name
}

output "glue_s3_access_policy_arn" {
  value = aws_iam_policy.glue_s3_access_policy.arn
}
