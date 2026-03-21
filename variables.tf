variable "name" {
  description = "Unique name used to create infrastructure resources"
  type        = string
}

variable "tags" {
  description = "A collection of tags to apply to infrastructure resources"
  type        = map(string)
}

variable "log_reader_type" {
  type        = string
  default     = "user"
  description = <<EOF
One of "user" or "role".
This will determine whether to create a log reader IAM user or IAM role.
This IAM identity has explicit permissions to read the created log group
EOF

  validation {
    condition     = contains(["user", "role"], var.log_reader_type)
    error_message = "log_reader_type must be one of 'user' or 'role'"
  }
}

variable "log_reader_role_principals" {
  type        = set(string)
  default     = []
  description = <<EOF
This is a set of AWS ARNs describing AWS principals that are allowed to assume this log reader.
EOF
}

variable "enable_get_metrics" {
  description = "Set to true to enable permissions on the log reader to get metric data"
  type        = bool
  default     = false
}

variable "kms_key_arn" {
  type        = string
  default     = null
  description = <<EOF
The AWS ARN of the KMS Key used to encrypt logs.
By default, set to null which disables encryption.
EOF
}

variable "retention_in_days" {
  type        = number
  default     = 0
  description = <<EOF
The number of days to retain logs.
By default, set to 0 which disables log expiration.
EOF
}
