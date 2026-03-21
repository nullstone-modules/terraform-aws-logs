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
    name       = try(aws_iam_user.log_reader[count.index].name, "")
    access_key = try(aws_iam_access_key.log_reader[count.index].id, "")
    secret_key = try(aws_iam_access_key.log_reader[count.index].secret, "")
    role_arn   = try(aws_iam_role.log_reader[count.index].arn, "")
  }

  description = "An AWS User or Role with explicit privilege to read logs from Cloudwatch."

  sensitive = true
}