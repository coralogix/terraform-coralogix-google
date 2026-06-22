variable "project_id" {
  description = "The GCP project ID. If not set, the provider project is used."
  type        = string
  default     = null
}

variable "gcp_region" {
  description = "The GCP region for PSC resources"
  type        = string
  default     = "us-central1"
}

variable "network_self_link" {
  description = "The existing VPC network self link, for example projects/<project>/global/networks/<name>"
  type        = string
}

variable "existing_psc_subnet_self_link" {
  description = "The existing PSC subnet self link"
  type        = string
}

variable "existing_private_dns_zone_name" {
  description = "The existing private Cloud DNS managed zone name"
  type        = string
}
