provider "google" {
}

module "private-service-connect" {
  source = "../../modules/v2/private-service-connect"

  project_id        = var.project_id
  gcp_region        = var.gcp_region
  network_self_link = var.network_self_link
  psc_subnet_name   = var.psc_subnet_name
  psc_subnet_cidr   = var.psc_subnet_cidr
}
