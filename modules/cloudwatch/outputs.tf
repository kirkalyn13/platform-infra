output "log_group_name" {
  value = aws_cloudwatch_log_group.app.name
}

output "lambda_log_group_name" {
  value = var.lambda_function_name != null ? aws_cloudwatch_log_group.lambda[0].name : null
}

output "cpu_alarm_arn" {
  value = var.instance_id != null ? aws_cloudwatch_metric_alarm.high_cpu[0].arn : null
}