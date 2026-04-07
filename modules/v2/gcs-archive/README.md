# GCS Archive Module

Terraform module to provision GCS buckets for Coralogix archive storage, with IAM permissions and optional CMEK encryption.

This is the GCP equivalent of the [AWS S3 archive module](https://registry.terraform.io/modules/coralogix/aws/coralogix/latest/examples/s3-archive).

## Usage

```hcl
module "gcs-archive" {
  source = "coralogix/google/coralogix//modules/v2/gcs-archive"

  gcp_region                = "us-central1"
  coralogix_service_account = "coralogix-archive@your-cx-project.iam.gserviceaccount.com"
  logs_bucket_name          = "my-coralogix-logs-archive"
  metrics_bucket_name       = "my-coralogix-metrics-archive"
}
```

### With CMEK encryption

```hcl
module "gcs-archive" {
  source = "coralogix/google/coralogix//modules/v2/gcs-archive"

  gcp_region                = "us-central1"
  coralogix_service_account = "coralogix-archive@your-cx-project.iam.gserviceaccount.com"
  logs_bucket_name          = "my-coralogix-logs-archive"
  metrics_bucket_name       = "my-coralogix-metrics-archive"
  logs_kms_key_name         = "projects/my-project/locations/us-central1/keyRings/my-ring/cryptoKeys/my-key"
  metrics_kms_key_name      = "projects/my-project/locations/us-central1/keyRings/my-ring/cryptoKeys/my-key"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| gcp_region | GCP region for the archive buckets | string | - | yes |
| coralogix_service_account | Coralogix archive service account email | string | - | yes |
| logs_bucket_name | Name for the logs/traces archive bucket | string | null | no |
| metrics_bucket_name | Name for the metrics archive bucket | string | null | no |
| project_id | GCP project ID (defaults to provider project) | string | null | no |
| storage_class | GCS storage class (STANDARD recommended) | string | "STANDARD" | no |
| logs_kms_key_name | Cloud KMS key for logs bucket CMEK | string | null | no |
| metrics_kms_key_name | Cloud KMS key for metrics bucket CMEK | string | null | no |
| logs_bucket_force_destroy | Force destroy logs bucket with objects | bool | false | no |
| metrics_bucket_force_destroy | Force destroy metrics bucket with objects | bool | false | no |
| labels | Labels to add to GCS resources | map(string) | {} | no |

## Outputs

| Name | Description |
|------|-------------|
| logs_bucket_name | Name of the logs archive bucket |
| logs_bucket_url | URL of the logs archive bucket |
| metrics_bucket_name | Name of the metrics archive bucket |
| metrics_bucket_url | URL of the metrics archive bucket |

## Notes

- **Storage class**: `STANDARD` is recommended to avoid retrieval fees when querying archived data from the Coralogix UI.
- **CMEK**: Cloud KMS keys must be in the same region as the buckets. The module automatically grants `roles/cloudkms.cryptoKeyEncrypterDecrypter` to the project's GCS service agent, which performs the actual encrypt/decrypt operations.
- **Service account**: Contact your Coralogix representative to obtain the correct service account email for your environment.
- You **cannot** use the same bucket for both metrics and logs.
