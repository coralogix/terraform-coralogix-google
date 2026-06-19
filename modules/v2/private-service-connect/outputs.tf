output "psc_subnet_name" {
  description = "The name of the PSC subnet."
  value       = google_compute_subnetwork.psc.name
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
  description = "The name of the private Cloud DNS zone, if created."
  value       = try(google_dns_managed_zone.private[0].name, null)
}

output "ingress_private_hostname" {
  description = "The private ingress hostname to use after PSC verification."
  value       = local.ingress_private_hostname
}

output "api_private_hostname" {
  description = "The private API hostname to use after PSC verification."
  value       = local.api_private_hostname
}
