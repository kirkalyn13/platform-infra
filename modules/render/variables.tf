variable "api_key" {
  type      = string
  sensitive = true
}

variable "owner_id" {
  type      = string
  sensitive = true
}

variable "services" {
  type = list(object({
    name   = string
    repo   = string
    branch = string
    region = string
    plan   = string
  }))
}