output "service_urls" {
  value = { for k, v in render_web_service.services : k => v.url }
}