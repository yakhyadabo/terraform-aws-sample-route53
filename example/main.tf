
locals {
  domains = {
    "example.org" = {
      sub_domain_names = ["dev", "stage", "test"]
    },
    "example.com" = {
      sub_domain_names = ["dev", "stage", "test"]
    }
  }
}

module "route53" {
  for_each = local.domains
  source               = "../module"
  region               = var.region
  project_name         = var.project.name
  environment          = var.project.environment
  root_domain          = each.key
  sub_domains           = each.value.sub_domain_names
}