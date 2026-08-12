# Changelog

## v1.1.2
#### **pubsub**
### 💡 Enhancements
- Update Cloud Function runtime to `nodejs22`.

## v1.1.1
#### **private-service-connect**
### ✨ Features
- Add `modules/v2/private-service-connect` for consumer-side Coralogix PSC endpoints, optional private DNS, and subnet/zone reuse.

## v1.1.0
#### **gcs-archive**
### ✨ Features
- Add `modules/v2/gcs-archive` for Coralogix GCS archive buckets (logs/metrics), IAM for the Coralogix service account, and optional CMEK.
- Introduce the `modules/v2/` path for new modules; clarify that only v1 `pubsub` and `storage` are deprecated.

## v1.0.3
#### **pubsub & storage**
### 💡 Enhancements 
- add variable `function_iam_member` to allow custom IAM members to the cloud function.
### 🛑 DEPRECATION NOTICE 🛑
- [NOTICE] The v1 modules (`pubsub` and `storage`) are deprecated in favor of the [gcp-logs](https://coralogix.com/docs/integrations/gcp/gcp-logs/) pull integration. Use the [v2 modules](./modules/v2/) for new deployments.
