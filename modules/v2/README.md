# v2 Modules

This directory contains the v2 versions of the Coralogix Google Cloud Platform Terraform modules. The existing modules in the parent directory (`modules/pubsub` and `modules/storage`) have been deprecated.

## Available Modules

- [gcs-archive](./gcs-archive) - Provision GCS buckets for Coralogix archive storage with IAM permissions and optional CMEK encryption.
- [private-service-connect](./private-service-connect) - Provision consumer-side GCP Private Service Connect endpoints and private DNS for Coralogix.
