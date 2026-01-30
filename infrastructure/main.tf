module "network" {
  source     = "./modules/network"
  project_id = var.project_id
  region     = var.region
}

module "compute" {
  source         = "./modules/compute"
  machine_type   = var.machine_type
  region         = var.region
  zone           = var.zone
  network_id     = module.network.network_id
  subnet_id      = module.network.subnet_id
  instance_count = var.instance_count
}

module "lb" {
  source         = "./modules/lb"
  instance_group = module.compute.instance_group
}
