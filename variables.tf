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
  type    = bool
  default = false
}
