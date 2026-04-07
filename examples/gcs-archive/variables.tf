variable "gcp_region" {
  description = "The GCP region for the archive buckets"
  type        = string
}

variable "coralogix_service_account" {
  description = "The Coralogix archive service account email"
  type        = string
}

variable "logs_bucket_name" {
  description = "Name for the logs/traces archive bucket"
  type        = string
  default     = null
}

variable "metrics_bucket_name" {
  description = "Name for the metrics archive bucket"
  type        = string
  default     = null
}

variable "logs_kms_key_name" {
  description = "Cloud KMS key for logs bucket CMEK encryption"
  type        = string
  default     = null
}

variable "metrics_kms_key_name" {
  description = "Cloud KMS key for metrics bucket CMEK encryption"
  type        = string
  default     = null
}

variable "logs_bucket_force_destroy" {
  description = "Force destroy logs bucket with objects"
  type        = bool
  default     = false
}

variable "metrics_bucket_force_destroy" {
  description = "Force destroy metrics bucket with objects"
  type        = bool
  default     = false
}
