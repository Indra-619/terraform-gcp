locals {
  common_labels = {
    company     = var.company_name
    environment = var.environment
    service     = var.service_name
    managed_by  = "terraform"
  }
}

module "network" {
  source       = "./modules/network"
  project_id   = var.project_id
  region       = var.region
  company_name = var.company_name
  environment  = var.environment
  service_name = var.service_name
}

module "compute" {
  source         = "./modules/compute"
  company_name   = var.company_name
  environment    = var.environment
  service_name   = var.service_name
  machine_type   = var.machine_type
  region         = var.region
  zone           = var.zone
  network_id     = module.network.network_id
  subnet_id      = module.network.subnet_id
  instance_count = var.instance_count
  labels         = local.common_labels
}

module "lb" {
  source         = "./modules/lb"
  company_name   = var.company_name
  environment    = var.environment
  service_name   = var.service_name
  instance_group = module.compute.instance_group
}
