resource "aws_secretsmanager_secret" "this" {
  for_each    = var.secrets
  name        = "${var.app_name}/${each.key}"
  description = "Secret '${each.key}' for ${var.app_name}"

  tags = {
    Name = "${var.app_name}-${each.key}"
  }
}

resource "aws_secretsmanager_secret_version" "this" {
  for_each      = var.secrets
  secret_id     = aws_secretsmanager_secret.this[each.key].id
  secret_string = each.value
}