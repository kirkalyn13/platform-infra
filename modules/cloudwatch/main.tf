resource "aws_cloudwatch_log_group" "app" {
  name              = "/aws/${var.app_name}/${var.env}"
  retention_in_days = 7
}

resource "aws_cloudwatch_log_group" "lambda" {
  count             = var.lambda_function_name != null ? 1 : 0
  name              = "/aws/lambda/${var.lambda_function_name}"
  retention_in_days = 7
}

resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  count               = var.create_cpu_alarm != null ? 1 : 0
  alarm_name          = "${var.app_name}-high-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = var.cpu_alarm_threshold

  dimensions = {
    InstanceId = var.instance_id
  }

  alarm_description = "Triggers when ${var.app_name} EC2 CPU exceeds ${var.cpu_alarm_threshold}%"
  treat_missing_data = "notBreaching"
}