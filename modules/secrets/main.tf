resource "aws_secretsmanager_secret" "api_key" {
  name        = "${var.app_name}/api-key"
  description = "API key for ${var.app_name}"

  tags = {
    Name = "${var.app_name}-api-key"
  }
}

resource "aws_secretsmanager_secret_version" "api_key" {
  secret_id     = aws_secretsmanager_secret.api_key.id
  secret_string = jsonencode({ api_key = var.api_key })
}
