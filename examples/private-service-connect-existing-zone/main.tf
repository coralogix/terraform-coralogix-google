provider "google" {
}

module "private-service-connect" {
  source = "../../modules/v2/private-service-connect"

  project_id                     = var.project_id
  gcp_region                     = var.gcp_region
  network_self_link              = var.network_self_link
  existing_psc_subnet_self_link  = var.existing_psc_subnet_self_link
  existing_private_dns_zone_name = var.existing_private_dns_zone_name
}
