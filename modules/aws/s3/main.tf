resource "aws_s3_bucket" "dev_bucket" {
  bucket = var.bucket_name
  tags   = var.tags
}
