module "vercel" {
  source    = "../../modules/vercel"
  api_token = var.vercel_api_token

  projects = [
    {
      name      = "kirkalynsantos"
      repo      = "kirkalyn13/kls-portfolio-site"
      framework = "nextjs"
    },
    {
      name      = "sea-ems"
      repo      = "kirkalyn13/equipment-monitoring-system-frontend"
      framework = "create-react-app"
    },
    {
      name      = "mgnl-groovy-generator-app"
      repo      = "kirkalyn13/mgnl-groovy-generator-app"
      framework = "vite"
    },
    {
      name      = "motor-monitor-frontend"
      repo      = "kirkalyn13/motor-monitor-frontend"
      framework = "nextjs"
    },
    {
      name      = "time-variance-authority"
      repo      = "kirkalyn13/tva-dashboard"
      framework = "create-react-app"
    }
  ]
}

module "render" {
  source  = "../../modules/render"
  api_key = var.render_api_key
  owner_id = var.render_owner_id

  services = [
    {
      name   = "equipment-monitoring-system-backend"
      repo   = "kirkalyn13/equipment-monitoring-system-backend"
      branch = "main"
      region = "singapore"
      plan   = "free"
    }
  ]
}