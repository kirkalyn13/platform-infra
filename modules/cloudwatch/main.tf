resource "aws_cloudwatch_log_group" "app" {
  name              = "/aws/${var.app_name}/${var.env}"
  retention_in_days = 7
}

resource "aws_cloudwatch_log_group" "lambda" {
  count             = var.lambda_function_name != null ? 1 : 0
  name              = "/aws/lambda/${var.lambda_function_name}"
  retention_in_days = 7
}