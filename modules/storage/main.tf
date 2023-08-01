locals {
  function_name = "Coralogix-GCS-${random_string.this.result}"
  coralogix_regions = {
    Europe    = "api.coralogix.com"
    Europe2   = "api.eu2.coralogix.com"
    India     = "api.app.coralogix.in"
    Singapore = "api.coralogixsg.com"
    US        = "api.coralogix.us"
    US2       = "cx498.coralogix.com"

  }
  coralogix_url = local.coralogix_regions[var.coralogix_region]
  labels = {
    provider = "coralogix"
    license  = "apache2"
  }
}

data "archive_file" "this" {
  type        = "zip"
  source_dir  = "${path.module}/src"
  output_path = "${path.module}/dist/gcsToCoralogix.zip"
}

resource "google_storage_bucket_object" "this" {
  name   = "gcsToCoralogix.zip"
  bucket = var.bucket
  source = data.archive_file.this.output_path
}

resource "random_string" "this" {
  length  = 12
  special = false
}

resource "google_cloudfunctions_function" "this" {
  name                  = local.function_name
  description           = "Send GCS logs to Coralogix."
  runtime               = "python38"
  available_memory_mb   = 1024
  timeout               = 60
  source_archive_bucket = google_storage_bucket_object.this.bucket
  source_archive_object = google_storage_bucket_object.this.name
  entry_point           = "to_coralogix"
  environment_variables = {
    CORALOGIX_LOG_URL        = "https://${local.coralogix_url}/api/v1/logs"
    CORALOGIX_TIME_DELTA_URL = "https://${local.coralogix_url}/sdk/v1/time"
    private_key              = var.private_key
    app_name                 = var.application_name
    sub_name                 = var.subsystem_name
    newline_pattern          = var.newline_pattern
  }
  event_trigger {
    event_type = "google.storage.object.finalize"
    resource   = var.bucket
  }
  labels = merge(var.labels, local.labels)
}

resource "google_cloudfunctions_function_iam_member" "this" {
  project        = google_cloudfunctions_function.this.project
  region         = google_cloudfunctions_function.this.region
  cloud_function = google_cloudfunctions_function.this.name
  role           = "roles/cloudfunctions.invoker"
  member         = "allUsers"
}
