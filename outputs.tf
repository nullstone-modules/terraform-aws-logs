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
    name       = try(aws_iam_user.log_reader.name, "")
    access_key = try(aws_iam_access_key.log_reader.id, "")
    secret_key = try(aws_iam_access_key.log_reader.secret, "")
  }

  description = "An AWS User with explicit privilege to read logs from Cloudwatch."

  sensitive = true
}