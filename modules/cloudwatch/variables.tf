variable "env" {
  type = string
}

variable "app_name" {
  type = string
}

variable "lambda_function_name" {
  type    = string
  default = null
}

variable "instance_id" {
  type    = string
  default = null
}

variable "create_cpu_alarm" {
  type    = bool
  default = false
}

variable "cpu_alarm_threshold" {
  type    = number
  default = 80
}