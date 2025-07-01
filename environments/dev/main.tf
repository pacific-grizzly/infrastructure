module "s3" {
  source      = "../../modules/aws/s3"
  bucket_name = var.bucket_name
  tags        = var.tags
  versioning_enabled = var.versioning_enabled
}

# module "cloudtrail" {
#   source = "../../modules/aws/cloudtrail_events_lambda"
# }