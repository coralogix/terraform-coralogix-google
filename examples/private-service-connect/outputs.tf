output "psc_subnet_name" {
  value = module.private-service-connect.psc_subnet_name
}

output "ingress_endpoint_ip" {
  value = module.private-service-connect.ingress_endpoint_ip
}

output "api_endpoint_ip" {
  value = module.private-service-connect.api_endpoint_ip
}

output "dns_zone_name" {
  value = module.private-service-connect.dns_zone_name
}

output "ingress_private_hostname" {
  value = module.private-service-connect.ingress_private_hostname
}

output "api_private_hostname" {
  value = module.private-service-connect.api_private_hostname
}
