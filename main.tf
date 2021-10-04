provider "google" {
  credentials   = var.credentials_file

  project       = var.project_id
  region        = var.region
  zone          = var.zone
}

module "network" {
  source        = "./Module/Network"

  project       = var.project_id
}

module "iam" {
  source        = "./Module/IAM"

  project       = var.project_id
  valohai_email = var.valohai_email
}

module "worker_queue" {
  source        = "./Module/Worker-Queue"

  project       = var.project_id
  region        = var.region
  zone          = var.zone
  vpc           = module.network.vpc
  queue_address = var.queue_address


  depends_on = [module.network]
}
