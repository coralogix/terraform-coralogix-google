variable "project_id" {
  description = "The GCP project ID. If not set, the provider project is used."
  type        = string
  default     = null
}

variable "gcp_region" {
  description = "The GCP region for the PSC subnet, addresses, and forwarding rules. Must match the Coralogix service attachment region."
  type        = string
}

variable "network_self_link" {
  description = "The existing VPC network in self link form, for example projects/<project>/global/networks/<name>."
  type        = string

  validation {
    condition     = can(regex("(^https://|^projects/).*/global/networks/[^/]+$", var.network_self_link))
    error_message = "network_self_link must be a VPC network self link such as projects/<project>/global/networks/<name>."
  }
}

variable "psc_subnet_name" {
  description = "Name of the PSC subnet. If use_existing_psc_subnet is true, this must match an existing subnet in the selected region."
  type        = string
  default     = "cx-psc-subnet"
}

variable "psc_subnet_cidr" {
  description = "CIDR range for the PSC subnet. Required when creating a subnet. The Coralogix guide uses a dedicated /28."
  type        = string
  default     = null

  validation {
    condition     = var.psc_subnet_cidr == null || can(cidrnetmask(var.psc_subnet_cidr)) && tonumber(split("/", var.psc_subnet_cidr)[1]) == 28
    error_message = "psc_subnet_cidr must be null or a valid /28 CIDR block."
  }
}

variable "use_existing_psc_subnet" {
  description = "Reuse an existing PSC subnet instead of creating one."
  type        = bool
  default     = false
}

variable "ingress_service_attachment" {
  description = "Coralogix ingress PSC service attachment URI."
  type        = string
  default     = "projects/coralogix-prod-saas-service/regions/us-central1/serviceAttachments/us3-psc-ingress-v1"
}

variable "api_service_attachment" {
  description = "Coralogix API PSC service attachment URI."
  type        = string
  default     = "projects/coralogix-prod-saas-service/regions/us-central1/serviceAttachments/us3-psc-api-v1"
}

variable "coralogix_domain" {
  description = "Coralogix regional domain used for the private DNS zone and records."
  type        = string
  default     = "us3.coralogix.com"
}

variable "allow_psc_global_access" {
  description = "Whether the PSC endpoints can be accessed from workloads in other regions of the same VPC."
  type        = bool
  default     = true
}

variable "create_private_dns_zone" {
  description = "Whether to create the private Cloud DNS zone and A records for the PSC endpoints."
  type        = bool
  default     = true
}

variable "dns_zone_name" {
  description = "Name of the private Cloud DNS managed zone to create when create_private_dns_zone is true."
  type        = string
  default     = "private-coralogix"
}

variable "existing_private_dns_zone_name" {
  description = "Existing private Cloud DNS managed zone name to use for record creation when create_private_dns_zone is false."
  type        = string
  default     = null
}

variable "dns_record_ttl" {
  description = "TTL for the private DNS A records."
  type        = number
  default     = 300
}

variable "ingress_address_name" {
  description = "Name of the reserved internal address for the ingress PSC endpoint."
  type        = string
  default     = "psc-ingress-ip"
}

variable "api_address_name" {
  description = "Name of the reserved internal address for the API PSC endpoint."
  type        = string
  default     = "psc-api-ip"
}

variable "ingress_forwarding_rule_name" {
  description = "Name of the ingress PSC forwarding rule."
  type        = string
  default     = "psc-coralogix-ingress"
}

variable "api_forwarding_rule_name" {
  description = "Name of the API PSC forwarding rule."
  type        = string
  default     = "psc-coralogix-api"
}

variable "labels" {
  description = "A map of labels to add to supported resources."
  type        = map(string)
  default     = {}
}
