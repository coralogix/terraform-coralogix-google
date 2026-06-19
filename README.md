# GCP Coralogix Terraform module

## Modules

### `private-service-connect`

Provision consumer-side GCP Private Service Connect endpoints and private DNS records for Coralogix.

```hcl
module "private-service-connect" {
  source = "coralogix/google/coralogix//modules/v2/private-service-connect"

  gcp_region        = "us-central1"
  network_self_link = "projects/my-project/global/networks/my-vpc"
  psc_subnet_cidr   = "10.100.16.0/28"
}
```

See the [private-service-connect module](https://github.com/coralogix/terraform-coralogix-google/tree/master/modules/v2/private-service-connect) for full documentation.

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

- [private-service-connect](https://github.com/coralogix/terraform-coralogix-google/tree/master/examples/private-service-connect) - Provision Coralogix PSC endpoints and private DNS in an existing VPC.
- [private-service-connect-existing-zone](https://github.com/coralogix/terraform-coralogix-google/tree/master/examples/private-service-connect-existing-zone) - Reuse an existing PSC subnet and private DNS zone for Coralogix endpoints.
- [gcs-archive](https://github.com/coralogix/terraform-coralogix-google/tree/master/examples/gcs-archive) - Provision GCS archive buckets for Coralogix.

## Deprecated v1 Modules

The v1 modules (`pubsub` and `storage`) are deprecated. See [modules/README.md](https://github.com/coralogix/terraform-coralogix-google/tree/master/modules/README.md) for details.

## Authors

Module is maintained by [Coralogix](https://github.com/coralogix).

## License

Apache 2.0 Licensed. See [LICENSE](https://github.com/coralogix/terraform-coralogix-google/tree/master/LICENSE) for full details.
