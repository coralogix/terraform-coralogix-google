## [NOTICE] This repo is being deprecated in favor of the [gcp-logs](https://coralogix.com/docs/integrations/gcp/gcp-logs/) pull integration. Please use the new integration for all new gcp logs integrations.
# [terraform-provider-coralogix](https://github.com/coralogix/terraform-provider-coralogix) provides `coralogix_integration` resource for this.
---

# GCP Coralogix Terraform module

## Usage

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

- [pubsub](https://github.com/coralogix/terraform-coralogix-google/tree/master/examples/pubsub) - Send logs from `PubSub` topic.
- [storage](https://github.com/coralogix/terraform-coralogix-google/tree/master/examples/storage) - Send logs from `GCS` bucket.

## Authors

Module is maintained by [Coralogix](https://github.com/coralogix).

## License

Apache 2.0 Licensed. See [LICENSE](https://github.com/coralogix/terraform-coralogix-google/tree/master/LICENSE) for full details.
