terraform {
  required_providers {
    render = {
      source  = "render-oss/render"
      version = "~> 1.0"
    }
  }
}

provider "render" {
  api_key = var.api_key
  owner_id = var.owner_id
}

resource "render_web_service" "services" {
  for_each = { for s in var.services : s.name => s }

  name   = each.value.name
  region = each.value.region
  plan   = each.value.plan

  start_command       = "npm start"


  runtime_source = {
    native_runtime = {
      auto_deploy         = false
      branch              = each.value.branch
      repo_url            = "https://github.com/${each.value.repo}"
      runtime             = "node"
      build_command       = "npm install"
    }
  }
}