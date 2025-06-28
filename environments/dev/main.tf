module "s3" {
  source      = "../../modules/aws/s3"
  bucket_name = var.bucket_name
  tags        = var.tags
}