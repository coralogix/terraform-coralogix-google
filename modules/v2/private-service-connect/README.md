# Private Service Connect Module

Terraform module to provision the consumer-side Google Cloud Private Service Connect resources needed to reach Coralogix privately.

## Usage

```hcl
module "private-service-connect" {
  source = "coralogix/google/coralogix//modules/v2/private-service-connect"

  gcp_region        = "us-central1"
  network_self_link = "projects/my-project/global/networks/my-vpc"
  psc_subnet_cidr   = "10.100.16.0/28"
}
```

Reuse an existing subnet and shared private zone:

```hcl
module "private-service-connect" {
  source = "coralogix/google/coralogix//modules/v2/private-service-connect"

  gcp_region                     = "us-central1"
  network_self_link              = "projects/my-project/global/networks/shared-vpc"
  existing_psc_subnet_self_link  = "projects/my-project/regions/us-central1/subnetworks/existing-psc-subnet"
  existing_private_dns_zone_name = "shared-private-zone"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| project_id | GCP project ID (defaults to provider project) | string | null | no |
| gcp_region | GCP region for PSC resources | string | - | yes |
| network_self_link | Existing VPC network self link such as `projects/<project>/global/networks/<name>` | string | - | yes |
| psc_subnet_name | Name of the PSC subnet to create when `existing_psc_subnet_self_link` is null | string | `"cx-psc-subnet"` | no |
| psc_subnet_cidr | CIDR block for the PSC subnet. Required when creating a subnet. | string | `null` | no |
| existing_psc_subnet_self_link | Existing PSC subnet self link to reuse instead of creating a new subnet | string | `null` | no |
| ingress_service_attachment | Coralogix ingress PSC service attachment URI in `gcp_region` | string | `"projects/coralogix-prod-saas-service/regions/us-central1/serviceAttachments/us3-psc-ingress-v1"` | no |
| api_service_attachment | Coralogix API PSC service attachment URI in `gcp_region` | string | `"projects/coralogix-prod-saas-service/regions/us-central1/serviceAttachments/us3-psc-api-v1"` | no |
| coralogix_domain | Coralogix regional domain for private DNS records | string | `"us3.coralogix.com"` | no |
| allow_psc_global_access | Allow access to the PSC endpoints from other regions in the same VPC. Leave `false` unless cross-region access is required. | bool | `false` | no |
| private_dns_zone_name | Private Cloud DNS zone name to create. Set to `null` to skip DNS records. | string | `"private-coralogix"` | no |
| existing_private_dns_zone_name | Existing private Cloud DNS zone name to use for record creation instead of creating a new zone | string | `null` | no |
| dns_record_ttl | TTL for private DNS A records | number | `300` | no |
| ingress_address_name | Name of the ingress endpoint address | string | `"psc-ingress-ip"` | no |
| api_address_name | Name of the API endpoint address | string | `"psc-api-ip"` | no |
| ingress_forwarding_rule_name | Name of the ingress forwarding rule | string | `"psc-coralogix-ingress"` | no |
| api_forwarding_rule_name | Name of the API forwarding rule | string | `"psc-coralogix-api"` | no |
| labels | Labels for supported resources | map(string) | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| psc_subnet_name | Name of the PSC subnet |
| psc_subnet_self_link | PSC subnet self link |
| ingress_endpoint_ip | Reserved ingress endpoint IP |
| api_endpoint_ip | Reserved API endpoint IP |
| ingress_forwarding_rule_name | Ingress forwarding rule name |
| ingress_forwarding_rule_self_link | Ingress forwarding rule self link |
| api_forwarding_rule_name | API forwarding rule name |
| api_forwarding_rule_self_link | API forwarding rule self link |
| dns_zone_name | Private Cloud DNS zone name, if created or reused for records |
| ingress_private_hostname | Private ingress hostname |
| api_private_hostname | Private API hostname |

## Notes

- This module creates private connectivity infrastructure only. It does not configure API keys, OTLP exporters, Fluent Bit, or other telemetry pipelines.
- Forwarding rules always set `no_automate_dns_zone = true` so Terraform-managed DNS stays explicit.
- Set `existing_psc_subnet_self_link` when the customer already owns the PSC subnet. Leave it `null` to let the module create one from `psc_subnet_name` and `psc_subnet_cidr`.
- When `existing_psc_subnet_self_link` points to a subnet created in the same root module, apply in two steps: create that subnet first, then run a full apply so the PSC address resources can read its self link.
- Set `existing_private_dns_zone_name` when the customer wants this module to create PSC `A` records in an existing private zone. It takes precedence over `private_dns_zone_name`.
- Set `private_dns_zone_name = null` and leave `existing_private_dns_zone_name = null` to manage DNS records outside this module.
- For non-us3 deployments, override `gcp_region`, `ingress_service_attachment`, `api_service_attachment`, and `coralogix_domain` together so the PSC endpoints and private DNS stay in the same Coralogix region.
- After verifying the endpoints, use `ingress.private.<region-domain>` for OTLP and log ingestion, and `api.private.<region-domain>` for the Coralogix API.
- This module is separate from the deprecated v1 `pubsub` and `storage` modules, and separate from `v2/gcs-archive`.
