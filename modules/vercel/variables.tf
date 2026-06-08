variable "api_token" {
  type      = string
  sensitive = true
}

variable "projects" {
  type = list(object({
    name      = string
    repo      = string
    framework = string
    domain    = optional(string)
  }))
}