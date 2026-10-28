// v0.2.0 added count to the log reader; these keep 0.1.x state from recreating the user and rotating its key.
moved {
  from = aws_iam_user.log_reader
  to   = aws_iam_user.log_reader[0]
}

moved {
  from = aws_iam_access_key.log_reader
  to   = aws_iam_access_key.log_reader[0]
}

moved {
  from = aws_iam_user_policy.log_reader
  to   = aws_iam_user_policy.log_reader[0]
}
