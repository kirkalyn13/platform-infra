variable "app_name" {
  type = string
}

variable "secrets" {
  type      = map(string)
  default   = {}
}