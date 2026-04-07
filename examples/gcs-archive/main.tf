provider "google" {
}

module "gcs-archive" {
  source = "../../modules/v2/gcs-archive"

  gcp_region                = var.gcp_region
  coralogix_service_account = var.coralogix_service_account
  logs_bucket_name          = var.logs_bucket_name
  metrics_bucket_name       = var.metrics_bucket_name
  logs_kms_key_name         = var.logs_kms_key_name
  metrics_kms_key_name      = var.metrics_kms_key_name
  logs_bucket_force_destroy = var.logs_bucket_force_destroy
  metrics_bucket_force_destroy = var.metrics_bucket_force_destroy
}
