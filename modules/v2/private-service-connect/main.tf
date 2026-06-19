locals {
  labels = merge({
    provider = "coralogix"
    module   = "private-service-connect"
  }, var.labels)

  private_dns_name           = "private.${var.coralogix_domain}."
  ingress_private_hostname   = "ingress.private.${var.coralogix_domain}"
  api_private_hostname       = "api.private.${var.coralogix_domain}"
  manage_private_dns_records = var.create_private_dns_zone || var.existing_private_dns_zone_name != null
}

data "google_compute_subnetwork" "psc" {
  count = var.use_existing_psc_subnet ? 1 : 0

  name    = var.psc_subnet_name
  project = var.project_id
  region  = var.gcp_region
}

resource "google_compute_subnetwork" "psc" {
  count = var.use_existing_psc_subnet ? 0 : 1

  name          = var.psc_subnet_name
  project       = var.project_id
  region        = var.gcp_region
  network       = var.network_self_link
  ip_cidr_range = var.psc_subnet_cidr
  description   = "Coralogix PSC endpoint subnet."
}

resource "google_compute_address" "ingress" {
  name         = var.ingress_address_name
  project      = var.project_id
  region       = var.gcp_region
  subnetwork   = var.use_existing_psc_subnet ? data.google_compute_subnetwork.psc[0].id : google_compute_subnetwork.psc[0].id
  address_type = "INTERNAL"
  description  = "Coralogix PSC ingress endpoint IP."
  labels       = local.labels
}

resource "google_compute_address" "api" {
  name         = var.api_address_name
  project      = var.project_id
  region       = var.gcp_region
  subnetwork   = var.use_existing_psc_subnet ? data.google_compute_subnetwork.psc[0].id : google_compute_subnetwork.psc[0].id
  address_type = "INTERNAL"
  description  = "Coralogix PSC API endpoint IP."
  labels       = local.labels
}

resource "google_compute_forwarding_rule" "ingress" {
  name                    = var.ingress_forwarding_rule_name
  project                 = var.project_id
  region                  = var.gcp_region
  load_balancing_scheme   = ""
  network                 = var.network_self_link
  ip_address              = google_compute_address.ingress.id
  target                  = var.ingress_service_attachment
  allow_psc_global_access = var.allow_psc_global_access
  no_automate_dns_zone    = true
  labels                  = local.labels
}

resource "google_compute_forwarding_rule" "api" {
  name                    = var.api_forwarding_rule_name
  project                 = var.project_id
  region                  = var.gcp_region
  load_balancing_scheme   = ""
  network                 = var.network_self_link
  ip_address              = google_compute_address.api.id
  target                  = var.api_service_attachment
  allow_psc_global_access = var.allow_psc_global_access
  no_automate_dns_zone    = true
  labels                  = local.labels
}

resource "google_dns_managed_zone" "private" {
  count = var.create_private_dns_zone ? 1 : 0

  name        = var.dns_zone_name
  project     = var.project_id
  dns_name    = local.private_dns_name
  description = "Coralogix PSC private DNS"
  visibility  = "private"
  labels      = local.labels

  private_visibility_config {
    networks {
      network_url = var.network_self_link
    }
  }
}

resource "google_dns_record_set" "ingress" {
  count = local.manage_private_dns_records ? 1 : 0

  project      = var.project_id
  managed_zone = var.create_private_dns_zone ? google_dns_managed_zone.private[0].name : var.existing_private_dns_zone_name
  name         = "${local.ingress_private_hostname}."
  type         = "A"
  ttl          = var.dns_record_ttl
  rrdatas      = [google_compute_address.ingress.address]
}

resource "google_dns_record_set" "api" {
  count = local.manage_private_dns_records ? 1 : 0

  project      = var.project_id
  managed_zone = var.create_private_dns_zone ? google_dns_managed_zone.private[0].name : var.existing_private_dns_zone_name
  name         = "${local.api_private_hostname}."
  type         = "A"
  ttl          = var.dns_record_ttl
  rrdatas      = [google_compute_address.api.address]
}
