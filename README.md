# GCP Coralogix Terraform module

## Modules

### `gcs-archive`

Provision GCS buckets for Coralogix archive storage with IAM permissions and optional CMEK encryption.

```hcl
module "gcs-archive" {
  source = "coralogix/google/coralogix//modules/v2/gcs-archive"

  gcp_region                = "us-central1"
  coralogix_service_account = "coralogix-archive@your-cx-project.iam.gserviceaccount.com"
  logs_bucket_name          = "my-coralogix-logs-archive"
  metrics_bucket_name       = "my-coralogix-metrics-archive"
}
```

See the [gcs-archive module](https://github.com/coralogix/terraform-coralogix-google/tree/master/modules/v2/gcs-archive) for full documentation.

## Examples

- [gcs-archive](https://github.com/coralogix/terraform-coralogix-google/tree/master/examples/gcs-archive) - Provision GCS archive buckets for Coralogix.

## Deprecated v1 Modules

The v1 modules (`pubsub` and `storage`) are deprecated. See [modules/README.md](https://github.com/coralogix/terraform-coralogix-google/tree/master/modules/README.md) for details.

## Authors

Module is maintained by [Coralogix](https://github.com/coralogix).

## License

Apache 2.0 Licensed. See [LICENSE](https://github.com/coralogix/terraform-coralogix-google/tree/master/LICENSE) for full details.
