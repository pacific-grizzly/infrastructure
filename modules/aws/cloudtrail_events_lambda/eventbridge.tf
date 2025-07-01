resource "aws_cloudwatch_event_rule" "dev_cw_event_rule" {
  name        = "pg-dev-bucket-0-delete-put-policy"
  event_pattern = jsonencode({
    "source": ["aws.s3"],
    "detail": {
      "eventName": ["DeleteObject", "PutBucketPolicy"]
    }
  })
}

resource "aws_cloudwatch_event_target" "dev_lambda_target" {
  rule      = aws_cloudwatch_event_rule.dev_cw_event_rule.name
  target_id = "RestoreObject"
  arn       = aws_lambda_function.restore_object.arn
}

resource "aws_lambda_permission" "dev_lambda_permission" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.restore_object.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.dev_cw_event_rule.arn
}
