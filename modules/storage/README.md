# storage

Manage the `Cloud Function` that retrieves logs from `GCS` bucket and sends them to your *Coralogix* account.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.1 |
| <a name="requirement_gcloud"></a> [gcloud](#requirement\_gcloud) | >= 395.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 4.31.0 |
| <a name="provider_archive"></a> [archive](#provider\_archive) | >= 2.2.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.3.2 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_coralogix_region"></a> [coralogix\_region](#input\_coralogix\_region) | The Coralogix location region, possible options are [`Europe`, `Europe2`, `India`, `Singapore`, `US`. `US2`] | `string` | `Europe` | no |
| <a name="input_private_key"></a> [private\_key](#input\_private\_key) | The Coralogix private key which is used to validate your authenticity | `string` | n/a | yes |
| <a name="input_application_name"></a> [application\_name](#input\_application\_name) | The name of your application | `string` | n/a | yes |
| <a name="input_subsystem_name"></a> [subsystem\_name](#input\_subsystem\_name) | The subsystem name of your application | `string` | n/a | yes |
| <a name="input_newline_pattern"></a> [newline\_pattern](#input\_newline\_pattern) | The pattern for lines splitting | `string` | `(?:\r\n\|\r\|\n)` | no |
| <a name="input_bucket"></a> [bucket](#input\_bucket) | The name of the GCS Bucket to watch | `string` | n/a | yes |
| <a name="input_labels"></a> [labels](#input\_labels) | A map of labels to add to Cloud Function | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_project"></a> [project](#output\_project) | GCP Project ID |
| <a name="output_region"></a> [region](#output\_region) | GCP Region |
| <a name="output_function"></a> [function](#output\_function) | GCP Cloud Function Name |
