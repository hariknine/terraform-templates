
module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 12.0"

  project_id   = var.project_id
  network_name = var.network_name
  routing_mode = "REGIONAL"

  subnets = [
    {
      subnet_name   = var.subnet_01_name
      subnet_ip     = var.subnet_01_ip
      subnet_region = var.region
    }
  ]
}