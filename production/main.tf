module "infra" {
  source           = "../infrastructure"
  environment_name = "production-live"
  asp_size         = "S2"
  custom_tags = {
    author = "Thorsten"
  }
  location = "westeurope"
}

output "website_url" {
  value     = module.infra.app_service_url
  sensitive = true
}
