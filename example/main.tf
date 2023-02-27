
module "route53" {
  source               = "../module"
  region               = var.region
  project_name         = var.project.name
  environment          = var.project.environment
  root_domain          = var.root_domain
  sub_domains           = var.sub_domains
}