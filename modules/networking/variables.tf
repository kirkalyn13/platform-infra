variable "app_name" {
  type = string
}

variable "vpc_cidr" {
  type    = string
  default = "192.168.0.0/26"
}

variable "aws_region" {
  type    = string
  default = "us-east-1"
}
