module "vercel" {
  source    = "../../modules/vercel"
  api_token = var.vercel_api_token

  projects = [
    {
      name      = "kls-portfolio-site"
      repo      = "kirkalyn13/kls-portfolio-site"
      framework = "nextjs"
      domain    = "kirkalynsantos.vercel.app"
    },
    {
      name      = "equipment-monitoring-system-frontend"
      repo      = "kirkalyn13/equipment-monitoring-system-frontend"
      framework = "create-react-app"
      domain    = "sea-ems.vercel.app"
    },
    {
      name      = "mgnl-groovy-generator-app"
      repo      = "kirkalyn13/mgnl-groovy-generator-app"
      framework = "vite"
      domain    = "mgnl-groovy-generator.vercel.app"
    },
    {
      name      = "motor-monitor-frontend"
      repo      = "kirkalyn13/motor-monitor-frontend"
      framework = "nextjs"
      domain    = "motor-monitor.vercel.app"
    },
    {
      name      = "tva-dashboard"
      repo      = "kirkalyn13/tva-dashboard"
      framework = "create-react-app"
      domain    = "time-variance-authority.vercel.app"
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