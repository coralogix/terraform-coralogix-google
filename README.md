# GCP Coralogix Terraform module

## v2 Modules

New modules are available under `modules/v2/`. Use these for all new deployments.

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

---

## Deprecated v1 Modules

> **[NOTICE]** The v1 modules (`modules/pubsub` and `modules/storage`) are deprecated in favor of the [gcp-logs](https://coralogix.com/docs/integrations/gcp/gcp-logs/) pull integration. Please use the new integration for all new GCP logs integrations. [terraform-provider-coralogix](https://github.com/coralogix/terraform-provider-coralogix) provides the `coralogix_integration` resource for this. Runtime support for [nodejs14](https://cloud.google.com/functions/docs/runtime-support#node.js) on Cloud Run Functions will decommission soon. **The v2 modules above are actively maintained.**

`pubsub`:

```hcl
module "pubsub" {
  source = "coralogix/google/coralogix//modules/pubsub"

  coralogix_region = "Europe"
  private_key      = "2f55c873-c0cf-4523-82d4-c3b68ee6cb46"
  application_name = "Pub/Sub"
  subsystem_name   = "logs"
  bucket           = "test-topic-name"
}
```

`storage`:

```hcl
module "storage" {
  source = "coralogix/google/coralogix//modules/storage"

  coralogix_region = "Europe"
  private_key      = "2f55c873-c0cf-4523-82d4-c3b68ee6cb46"
  application_name = "GCS"
  subsystem_name   = "logs"
  bucket           = "test-bucket-name"
}
```

## Examples

- [gcs-archive](https://github.com/coralogix/terraform-coralogix-google/tree/master/examples/gcs-archive) - Provision GCS archive buckets for Coralogix.
- [pubsub](https://github.com/coralogix/terraform-coralogix-google/tree/master/examples/pubsub) - Send logs from `PubSub` topic. *(deprecated)*
- [storage](https://github.com/coralogix/terraform-coralogix-google/tree/master/examples/storage) - Send logs from `GCS` bucket. *(deprecated)*

## Authors

Module is maintained by [Coralogix](https://github.com/coralogix).

## License

Apache 2.0 Licensed. See [LICENSE](https://github.com/coralogix/terraform-coralogix-google/tree/master/LICENSE) for full details.
