variable "bucket_name" {
  type        = string
  description = "Name of bucket"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags for bucket"
}

variable "versioning_enabled" {
  type        = bool
  default     = false
  description = "Enable versioning bucket"
}