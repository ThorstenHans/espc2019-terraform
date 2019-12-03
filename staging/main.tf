module "infra" {
  source           = "../infrastructure"
  environment_name = "staging-live"
  asp_size         = "S1"
  custom_tags = {
    author = "Thorsten"
  }
  location = "westeurope"
}

output "website_url" {
  value = module.infra.app_service_url
}
