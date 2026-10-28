output "arn" {
  value       = aws_cloudwatch_log_group.this.arn
  description = "Cloudwatch Log Group ARN"
}

output "name" {
  value       = aws_cloudwatch_log_group.this.name
  description = "Cloudwatch Log Group Name"
}

output "reader" {
  value = {
    name       = try(aws_iam_user.log_reader[0].name, "")
    access_key = try(aws_iam_access_key.log_reader[0].id, "")
    secret_key = try(aws_iam_access_key.log_reader[0].secret, "")
    role_arn   = try(aws_iam_role.log_reader[0].arn, "")
  }

  description = "An AWS User or Role with explicit privilege to read logs from Cloudwatch."

  sensitive = true
}

output "reader_role_arn" {
  value       = try(aws_iam_role.log_reader[0].arn, "")
  description = <<EOT
ARN of the log reader IAM Role when `log_reader_type = "role"`; empty string otherwise.
This output is not sensitive so that consumers can expose the role for AssumeRole without
inheriting the sensitivity of `reader` (which also carries IAM User access keys).
EOT
}
