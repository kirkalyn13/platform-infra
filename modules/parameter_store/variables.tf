variable "app_name" {
  type = string
}

variable "parameters" {
  type    = map(string)
  default = {}
}