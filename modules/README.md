# Deprecated v1 Modules

> **[NOTICE]** The v1 modules (`pubsub` and `storage`) are deprecated in favor of the [gcp-logs](https://coralogix.com/docs/integrations/gcp/gcp-logs/) pull integration. Please use the new integration for all new GCP logs integrations. [terraform-provider-coralogix](https://github.com/coralogix/terraform-provider-coralogix) provides the `coralogix_integration` resource for this. Runtime support for [nodejs14](https://cloud.google.com/functions/docs/runtime-support#node.js) on Cloud Run Functions will decommission soon.

For new deployments, use the [v2 modules](./v2/).

---

## `pubsub`

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

## `storage`

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
