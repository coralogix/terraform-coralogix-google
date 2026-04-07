variable "logs_bucket_name" {
  description = "Name for the GCS bucket to store logs and traces archive. If not set, no logs bucket will be created."
  type        = string
  default     = null
}

variable "metrics_bucket_name" {
  description = "Name for the GCS bucket to store metrics archive. If not set, no metrics bucket will be created."
  type        = string
  default     = null
}

variable "coralogix_service_account" {
  description = "The Coralogix archive service account email to grant bucket access. Contact your Coralogix representative to obtain the correct service account for your environment."
  type        = string
}

variable "gcp_region" {
  description = "The GCP region for the archive buckets. Must match the region associated with your Coralogix account."
  type        = string
}

variable "project_id" {
  description = "The GCP project ID. If not set, the provider project is used."
  type        = string
  default     = null
}

variable "storage_class" {
  description = "The storage class for the GCS buckets. STANDARD is recommended to avoid retrieval fees when querying archived data."
  type        = string
  default     = "STANDARD"
  validation {
    condition     = contains(["STANDARD", "NEARLINE", "COLDLINE", "ARCHIVE"], var.storage_class)
    error_message = "The storage_class must be one of: STANDARD, NEARLINE, COLDLINE, ARCHIVE."
  }
}

variable "logs_kms_key_name" {
  description = "Cloud KMS key resource name for logs bucket CMEK encryption (e.g. projects/PROJECT/locations/REGION/keyRings/RING/cryptoKeys/KEY). Must be in the same region as the bucket."
  type        = string
  default     = null
}

variable "metrics_kms_key_name" {
  description = "Cloud KMS key resource name for metrics bucket CMEK encryption (e.g. projects/PROJECT/locations/REGION/keyRings/RING/cryptoKeys/KEY). Must be in the same region as the bucket."
  type        = string
  default     = null
}

variable "logs_bucket_force_destroy" {
  description = "When deleting the logs bucket, delete all objects in the bucket first."
  type        = bool
  default     = false
}

variable "metrics_bucket_force_destroy" {
  description = "When deleting the metrics bucket, delete all objects in the bucket first."
  type        = bool
  default     = false
}

variable "labels" {
  description = "A map of labels to add to GCS resources."
  type        = map(string)
  default     = {}
}
