locals {
  labels = merge({
    provider = "coralogix"
    module   = "private-service-connect"
  }, var.labels)

  private_dns_name               = "private.${var.coralogix_domain}."
  ingress_private_hostname       = "ingress.private.${var.coralogix_domain}"
  api_private_hostname           = "api.private.${var.coralogix_domain}"
  managed_private_dns_zone_count = var.existing_private_dns_zone_name == null && var.private_dns_zone_name != null ? 1 : 0
  private_dns_zone_name          = var.existing_private_dns_zone_name != null ? var.existing_private_dns_zone_name : var.private_dns_zone_name
  manage_private_dns_records     = local.private_dns_zone_name != null
}

resource "google_compute_subnetwork" "psc" {
  count = var.existing_psc_subnet_self_link != null ? 0 : 1

  name          = var.psc_subnet_name
  project       = var.project_id
  region        = var.gcp_region
  network       = var.network_self_link
  ip_cidr_range = var.psc_subnet_cidr
  description   = "Coralogix PSC endpoint subnet."

  lifecycle {
    precondition {
      condition     = var.psc_subnet_cidr != null
      error_message = "psc_subnet_cidr is required when existing_psc_subnet_self_link is null."
    }
  }
}

resource "google_compute_address" "ingress" {
  name         = var.ingress_address_name
  project      = var.project_id
  region       = var.gcp_region
  subnetwork   = var.existing_psc_subnet_self_link != null ? var.existing_psc_subnet_self_link : google_compute_subnetwork.psc[0].self_link
  address_type = "INTERNAL"
  description  = "Coralogix PSC ingress endpoint IP."
  labels       = local.labels
}

resource "google_compute_address" "api" {
  name         = var.api_address_name
  project      = var.project_id
  region       = var.gcp_region
  subnetwork   = var.existing_psc_subnet_self_link != null ? var.existing_psc_subnet_self_link : google_compute_subnetwork.psc[0].self_link
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

  lifecycle {
    precondition {
      condition     = can(regex("(^https://|^projects/).*/regions/${var.gcp_region}/serviceAttachments/[^/]+$", var.ingress_service_attachment))
      error_message = "ingress_service_attachment must be a service attachment self link in gcp_region."
    }
  }
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

  lifecycle {
    precondition {
      condition     = can(regex("(^https://|^projects/).*/regions/${var.gcp_region}/serviceAttachments/[^/]+$", var.api_service_attachment))
      error_message = "api_service_attachment must be a service attachment self link in gcp_region."
    }
  }
}

resource "google_dns_managed_zone" "private" {
  count = local.managed_private_dns_zone_count

  name        = var.private_dns_zone_name
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
  count      = local.manage_private_dns_records ? 1 : 0
  depends_on = [google_dns_managed_zone.private]

  project      = var.project_id
  managed_zone = local.private_dns_zone_name
  name         = "${local.ingress_private_hostname}."
  type         = "A"
  ttl          = var.dns_record_ttl
  rrdatas      = [google_compute_address.ingress.address]
}

resource "google_dns_record_set" "api" {
  count      = local.manage_private_dns_records ? 1 : 0
  depends_on = [google_dns_managed_zone.private]

  project      = var.project_id
  managed_zone = local.private_dns_zone_name
  name         = "${local.api_private_hostname}."
  type         = "A"
  ttl          = var.dns_record_ttl
  rrdatas      = [google_compute_address.api.address]
}
