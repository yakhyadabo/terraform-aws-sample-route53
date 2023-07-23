
locals {
  domains = {
    "example.org" = {
      private = false,
      sub_domain_names = ["dev", "stage", "test"]
    },
    "example.com" = {
      private = false,
      sub_domain_names = ["dev", "stage", "test"]
    }
  }
}

module "route53" {
  for_each = local.domains
  source               = "../../module"
  region               = var.region
  project_name         = var.project.name
  environment          = var.project.environment
  root_domain          = each.key
  private               = each.value.private
  sub_domains           = each.value.sub_domain_names
}