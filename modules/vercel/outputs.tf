output "project_urls" {
  value = { for k, v in vercel_project.apps : k => v.id }
}