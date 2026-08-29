# -------------------------------------------------------------------
# IAM — role + policy so the instance can read its secret
# -------------------------------------------------------------------

resource "aws_iam_role" "ec2" {
  name = "${var.app_name}-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })

  tags = {
    Name = "${var.app_name}-ec2-role"
  }
}

resource "aws_iam_policy" "read_secret" {
  count       = length(var.secret_arns) > 0 ? 1 : 0
  name        = "${var.app_name}-read-secret"
  description = "Allow EC2 to read the app API key from Secrets Manager"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "secretsmanager:GetSecretValue",
        "secretsmanager:DescribeSecret"
      ]
      Resource = values(var.secret_arns)
    }]
  })
}

resource "aws_iam_policy" "read_parameters" {
  count       = length(var.parameter_names) > 0 ? 1 : 0
  name        = "${var.app_name}-read-parameters"
  description = "Allow EC2 to read app config from Parameter Store"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "ssm:GetParameter",
        "ssm:GetParameters"
      ]
      Resource = [for name in var.parameter_names : "arn:aws:ssm:*:*:parameter/${var.app_name}/${name}"]
    }]
  })
}

resource "aws_iam_role_policy_attachment" "read_secret" {
  count      = length(var.secret_arns) > 0 ? 1 : 0
  role       = aws_iam_role.ec2.name
  policy_arn = aws_iam_policy.read_secret[0].arn
}

resource "aws_iam_role_policy_attachment" "read_parameters" {
  count      = length(var.parameter_names) > 0 ? 1 : 0
  role       = aws_iam_role.ec2.name
  policy_arn = aws_iam_policy.read_parameters[0].arn
}

# -------------------------------------------------------------------
# Security Group — inbound on app port + SSH, outbound open
# -------------------------------------------------------------------

resource "aws_security_group" "ec2" {
  name        = "${var.app_name}-ec2-sg"
  description = "Allow inbound traffic to application"
  vpc_id      = var.vpc_id

  ingress {
    description = "App port"
    from_port   = var.app_port
    to_port     = var.app_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH - restrict to your IP in the env"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.app_name}-ec2-sg"
  }
}

# -------------------------------------------------------------------
# EC2 Instance
# -------------------------------------------------------------------

resource "aws_instance" "app" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.ec2.id]
  iam_instance_profile        = aws_iam_instance_profile.ec2.name
  associate_public_ip_address = true

  user_data = base64encode(templatefile("${path.root}/scripts/user_data.sh", {
    secret_arns     = var.secret_arns
    parameter_names = var.parameter_names
    aws_region      = var.aws_region
    app_jar_path    = var.app_jar_path
    app_port        = var.app_port
  }))

  tags = {
    Name = "${var.app_name}-instance"
  }
}
