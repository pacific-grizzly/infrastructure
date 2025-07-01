resource "aws_s3_bucket" "dev_ct_bucket" {
  bucket = "pg-dev-cloudtrail-logs-0"
}

data "aws_caller_identity" "current" {}

resource "aws_s3_bucket_policy" "dev_ct_bucket_policy" {
  bucket = aws_s3_bucket.dev_ct_bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "AWSCloudTrailAclCheck",
        Effect    = "Allow",
        Principal = { Service = "cloudtrail.amazonaws.com" },
        Action    = "s3:GetBucketAcl",
        Resource  = "arn:aws:s3:::${aws_s3_bucket.dev_ct_bucket.id}"
      },
      {
        Sid       = "AWSCloudTrailWrite",
        Effect    = "Allow",
        Principal = { Service = "cloudtrail.amazonaws.com" },
        Action    = "s3:PutObject",
        Resource  = "arn:aws:s3:::${aws_s3_bucket.dev_ct_bucket.id}/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
        Condition = {
          StringEquals = {
            "s3:x-amz-acl" = "bucket-owner-full-control"
          }
        }
      }
    ]
  })
}

resource "aws_cloudtrail" "dev_ct" {
  name                          = "pg-dev-bucket-0-events"
  s3_bucket_name                = aws_s3_bucket.dev_ct_bucket.bucket
  enable_logging                = true
  event_selector {
    read_write_type           = "All"
    include_management_events = true
    data_resource {
      type   = "AWS::S3::Object"
      values = ["arn:aws:s3:::pg-dev-bucket-0/"]
    }
  }
}
