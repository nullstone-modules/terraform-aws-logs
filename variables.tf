variable "name" {
  description = "Unique name used to create infrastructure resources"
  type        = string
}

variable "tags" {
  description = "A collection of tags to apply to infrastructure resources"
  type        = map(string)
}

variable "enable_log_reader" {
  description = "Set to true to create an AWS user that has explicit permissions to read the created log group"
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
