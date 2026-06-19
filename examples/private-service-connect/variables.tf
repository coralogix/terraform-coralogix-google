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
  description = "The self link or id of the existing VPC network"
  type        = string
}

variable "psc_subnet_name" {
  description = "The name of the PSC subnet"
  type        = string
  default     = "cx-psc-subnet"
}

variable "psc_subnet_cidr" {
  description = "A non-overlapping /28 CIDR block for the PSC subnet"
  type        = string
  default     = "10.100.16.0/28"
}
