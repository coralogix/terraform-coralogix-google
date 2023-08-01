locals {
  function_name = "Coralogix-PubSub-${random_string.this.result}"
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

data "google_client_config" "this" {}

data "archive_file" "this" {
  type        = "zip"
  source_dir  = "${path.module}/src"
  output_path = "${path.module}/dist/gcsToCoralogix.zip"
}

resource "random_string" "this" {
  length  = 12
  special = false
}

resource "google_storage_bucket" "this" {
  name          = lower("${local.function_name}-source")
  location      = upper(data.google_client_config.this.region)
  force_destroy = true
  labels        = merge(var.labels, local.labels)
}

resource "google_storage_bucket_object" "this" {
  name   = "pubsubToCoralogix-${data.archive_file.this.output_md5}.zip"
  bucket = google_storage_bucket.this.name
  source = data.archive_file.this.output_path
}

resource "google_cloudfunctions_function" "this" {
  name                  = local.function_name
  description           = "Send PubSub logs to Coralogix."
  runtime               = "nodejs14"
  available_memory_mb   = 1024
  timeout               = 60
  source_archive_bucket = google_storage_bucket_object.this.bucket
  source_archive_object = google_storage_bucket_object.this.name
  entry_point           = "mainPubSub"
  environment_variables = {
    CORALOGIX_URL        = local.coralogix_url
    private_key              = var.private_key
    app_name                 = var.application_name
    sub_name                 = var.subsystem_name
    newline_pattern          = var.newline_pattern
    sampling                 = var.sampling
  }
  event_trigger {
    event_type = "google.pubsub.topic.publish"
    resource   = var.topic
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