resource "aws_iam_role" "dev_lambda_role" {
  name = "pg-dev-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = { Service = "lambda.amazonaws.com" },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy" "dev_lambda_policy" {
  name = "pg-dev-lambda-policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:ListBucketVersions",
          "s3:ListBucket",
          "s3:GetObjectVersion",
          "s3:PutObject",
          "s3:CopyObject"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = "logs:*",
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "dev_policy_attachment" {
  role       = aws_iam_role.dev_lambda_role.name
  policy_arn = aws_iam_policy.dev_lambda_policy.arn
}

resource "aws_lambda_function" "restore_object" {
  filename         = "${path.module}/lambda.zip"
  function_name    = "pg-dev-lambda-restore"
  role             = aws_iam_role.dev_lambda_role.arn
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.12"
  source_code_hash = filebase64sha256("${path.module}/lambda.zip")
}
