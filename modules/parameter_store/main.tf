resource "aws_ssm_parameter" "this" {
  for_each = var.parameters
  name     = "/${var.app_name}/${each.key}"
  type     = "String"
  value    = each.value

  tags = {
    Name = "${var.app_name}-${each.key}"
  }
}