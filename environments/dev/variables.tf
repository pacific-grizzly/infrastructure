variable "bucket_name" {
  type        = string
  description = "Name of the S3 bucket"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags for the S3 bucket"
}

variable "versioning_enabled" {
  type        = bool
  default     = false
  description = "Enable versioning bucket"
}