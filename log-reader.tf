locals {
  # The log reader name must be /aws/lambda/{function_name} to properly capture lambda logs
  #   However, a username cannot contain '/'.
  #   Let's drop `/aws/lambda/` from the name to create a safe user name
  safe_username = replace(trimprefix(var.name, "/aws/"), "/", "-")
}

resource "aws_iam_user" "log_reader" {
  name = "log-reader-${local.safe_username}"
  tags = var.tags
}

resource "aws_iam_access_key" "log_reader" {
  user = aws_iam_user.log_reader.name
}

resource "aws_iam_user_policy" "log_reader" {
  name   = "AllowReadLogs"
  user   = aws_iam_user.log_reader.name
  policy = data.aws_iam_policy_document.log_reader.json
}

data "aws_iam_policy_document" "log_reader" {
  statement {
    sid    = "AllowReadLogs"
    effect = "Allow"

    actions = [
      "logs:Get*",
      "logs:List*",
      "logs:StartQuery",
      "logs:StopQuery",
      "logs:TestMetricFilter",
      "logs:Filter*"
    ]

    resources = [
      "${aws_cloudwatch_log_group.this.arn}:log-stream:*"
    ]
  }

  dynamic "statement" {
    for_each = var.enable_get_metrics ? [""] : []

    content {
      sid       = "AllowGetMetrics"
      effect    = "Allow"
      resources = ["*"] // Metrics cannot be restricted by resource

      actions = [
        "cloudwatch:GetMetricData",
        "cloudwatch:GetMetricStatistics",
        "cloudwatch:ListMetrics",
      ]
    }
  }
}
