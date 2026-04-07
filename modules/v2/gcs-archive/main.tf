locals {
  create_logs_bucket    = var.logs_bucket_name != null
  create_metrics_bucket = var.metrics_bucket_name != null
  needs_cmek            = (local.create_logs_bucket && var.logs_kms_key_name != null) || (local.create_metrics_bucket && var.metrics_kms_key_name != null)

  labels = merge({
    provider = "coralogix"
    module   = "gcs-archive"
  }, var.labels)
}

# The GCS service agent performs CMEK encrypt/decrypt on behalf of the bucket.
data "google_storage_project_service_account" "gcs_account" {
  count   = local.needs_cmek ? 1 : 0
  project = var.project_id
}

# --- Logs bucket ---

resource "google_storage_bucket" "logs" {
  count = local.create_logs_bucket ? 1 : 0

  name          = var.logs_bucket_name
  location      = var.gcp_region
  project       = var.project_id
  storage_class = var.storage_class
  force_destroy = var.logs_bucket_force_destroy

  uniform_bucket_level_access = true

  dynamic "encryption" {
    for_each = var.logs_kms_key_name != null ? [1] : []
    content {
      default_kms_key_name = var.logs_kms_key_name
    }
  }

  labels = local.labels
}

resource "google_storage_bucket_iam_member" "logs_object_admin" {
  count = local.create_logs_bucket ? 1 : 0

  bucket = google_storage_bucket.logs[0].name
  role   = "roles/storage.objectAdmin"
  member = "serviceAccount:${var.coralogix_service_account}"
}

resource "google_kms_crypto_key_iam_member" "logs_cmek" {
  count = local.create_logs_bucket && var.logs_kms_key_name != null ? 1 : 0

  crypto_key_id = var.logs_kms_key_name
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member        = "serviceAccount:${data.google_storage_project_service_account.gcs_account[0].email_address}"
}

# --- Metrics bucket ---

resource "google_storage_bucket" "metrics" {
  count = local.create_metrics_bucket ? 1 : 0

  name          = var.metrics_bucket_name
  location      = var.gcp_region
  project       = var.project_id
  storage_class = var.storage_class
  force_destroy = var.metrics_bucket_force_destroy

  uniform_bucket_level_access = true

  dynamic "encryption" {
    for_each = var.metrics_kms_key_name != null ? [1] : []
    content {
      default_kms_key_name = var.metrics_kms_key_name
    }
  }

  labels = local.labels
}

resource "google_storage_bucket_iam_member" "metrics_object_admin" {
  count = local.create_metrics_bucket ? 1 : 0

  bucket = google_storage_bucket.metrics[0].name
  role   = "roles/storage.objectAdmin"
  member = "serviceAccount:${var.coralogix_service_account}"
}

resource "google_kms_crypto_key_iam_member" "metrics_cmek" {
  count = local.create_metrics_bucket && var.metrics_kms_key_name != null ? 1 : 0

  crypto_key_id = var.metrics_kms_key_name
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member        = "serviceAccount:${data.google_storage_project_service_account.gcs_account[0].email_address}"
}
