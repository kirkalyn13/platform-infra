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
  name        = "${var.app_name}-read-secret"
  description = "Allow EC2 to read the app API key from Secrets Manager"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = [
        "secretsmanager:GetSecretValue",
        "secretsmanager:DescribeSecret"
      ]
      Resource = var.api_secret_arn
    }]
  })
}

resource "aws_iam_role_policy_attachment" "read_secret" {
  role       = aws_iam_role.ec2.name
  policy_arn = aws_iam_policy.read_secret.arn
}

resource "aws_iam_instance_profile" "ec2" {
  name = "${var.app_name}-ec2-profile"
  role = aws_iam_role.ec2.name
}

# -------------------------------------------------------------------
# Security Group — inbound on app port + SSH, outbound open
# -------------------------------------------------------------------

resource "aws_security_group" "ec2" {
  name        = "${var.app_name}-ec2-sg"
  description = "Allow inbound traffic to Spring Boot app"
  vpc_id      = var.vpc_id

  ingress {
    description = "Spring Boot app port"
    from_port   = var.app_port
    to_port     = var.app_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH - restrict to your IP in prod"
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
    api_secret_arn = var.api_secret_arn
    aws_region     = var.aws_region
    app_jar_path   = var.app_jar_path
    app_port       = var.app_port
  }))

  tags = {
    Name = "${var.app_name}-instance"
  }
}
