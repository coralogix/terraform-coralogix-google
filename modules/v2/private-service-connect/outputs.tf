output "psc_subnet_name" {
  description = "The name of the PSC subnet."
  value       = var.existing_psc_subnet_self_link != null ? element(reverse(split("/", var.existing_psc_subnet_self_link)), 0) : var.psc_subnet_name
}

output "psc_subnet_self_link" {
  description = "The self link of the PSC subnet."
  value       = var.existing_psc_subnet_self_link != null ? var.existing_psc_subnet_self_link : google_compute_subnetwork.psc[0].self_link
}

output "ingress_endpoint_ip" {
  description = "The private IP address reserved for the ingress PSC endpoint."
  value       = google_compute_address.ingress.address
}

output "api_endpoint_ip" {
  description = "The private IP address reserved for the API PSC endpoint."
  value       = google_compute_address.api.address
}

output "ingress_forwarding_rule_name" {
  description = "The name of the ingress PSC forwarding rule."
  value       = google_compute_forwarding_rule.ingress.name
}

output "ingress_forwarding_rule_self_link" {
  description = "The self link of the ingress PSC forwarding rule."
  value       = google_compute_forwarding_rule.ingress.self_link
}

output "api_forwarding_rule_name" {
  description = "The name of the API PSC forwarding rule."
  value       = google_compute_forwarding_rule.api.name
}

output "api_forwarding_rule_self_link" {
  description = "The self link of the API PSC forwarding rule."
  value       = google_compute_forwarding_rule.api.self_link
}

output "dns_zone_name" {
  description = "The name of the private Cloud DNS zone, if created or reused for records."
  value       = local.private_dns_zone_name
}

output "ingress_private_hostname" {
  description = "The private ingress hostname to use after PSC verification."
  value       = local.ingress_private_hostname
}

output "api_private_hostname" {
  description = "The private API hostname to use after PSC verification."
  value       = local.api_private_hostname
}
