output "logs_bucket_name" {
  description = "The name of the logs archive GCS bucket."
  value       = try(google_storage_bucket.logs[0].name, null)
}

output "logs_bucket_url" {
  description = "The URL of the logs archive GCS bucket."
  value       = try(google_storage_bucket.logs[0].url, null)
}

output "metrics_bucket_name" {
  description = "The name of the metrics archive GCS bucket."
  value       = try(google_storage_bucket.metrics[0].name, null)
}

output "metrics_bucket_url" {
  description = "The URL of the metrics archive GCS bucket."
  value       = try(google_storage_bucket.metrics[0].url, null)
}
