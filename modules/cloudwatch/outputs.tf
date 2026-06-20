output "log_group_name" {
  value = aws_cloudwatch_log_group.app.name
}

output "lambda_log_group_name" {
  value = var.lambda_function_name != null ? aws_cloudwatch_log_group.lambda[0].name : null
}