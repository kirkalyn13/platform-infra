variable "app_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "ami_id" {
  type    = string
  default = "ami-00000000"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "app_port" {
  type    = number
  default = 8080
}

variable "app_jar_path" {
  type = string
}

variable "api_secret_arn" {
  description = "ARN of the Secrets Manager secret containing the API key"
  type        = string
}

variable "aws_region" {
  type    = string
  default = "us-east-1"
}
