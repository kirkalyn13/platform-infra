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

variable "create_public_subnet" {
  type    = bool
  default = true
}

variable "create_private_subnet" {
  type    = bool
  default = false
}