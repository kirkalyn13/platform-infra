terraform {
  required_providers {
    vercel = {
      source  = "vercel/vercel"
      version = "~> 1.0"
    }
  }
}

provider "vercel" {
  api_token = var.api_token
}

resource "vercel_project" "apps" {
  for_each  = { for p in var.projects : p.name => p }

  name      = each.value.name
  framework = each.value.framework

  git_repository = {
    type = "github"
    repo = each.value.repo
  }
}

resource "vercel_project_domain" "domain" {
  for_each   = { for p in var.projects : p.name => p if p.domain != null }

  project_id = vercel_project.apps[each.key].id
  domain     = each.value.domain
}