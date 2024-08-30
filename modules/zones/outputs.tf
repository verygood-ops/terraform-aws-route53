# Updated outputs
output "route53_zone_zone_id" {
  description = "Zone ID of Route53 zone"
  value       = { for k, v in var.zones : k => aws_route53_zone.this["${k}_${sha256(k)}"].zone_id }
}

output "route53_zone_zone_arn" {
  description = "Zone ARN of Route53 zone"
  value       = { for k, v in var.zones : k => aws_route53_zone.this["${k}_${sha256(k)}"].arn }
}

output "route53_zone_name_servers" {
  description = "Name servers of Route53 zone"
  value       = { for k, v in var.zones : k => aws_route53_zone.this["${k}_${sha256(k)}"].name_servers }
}

output "primary_name_server" {
  description = "The Route 53 name server that created the SOA record."
  value       = { for k, v in var.zones : k => aws_route53_zone.this["${k}_${sha256(k)}"].primary_name_server }
}

output "route53_zone_name" {
  description = "Name of Route53 zone"
  value       = { for k, v in var.zones : k => aws_route53_zone.this["${k}_${sha256(k)}"].name }
}

output "route53_static_zone_name" {
  description = "Name of Route53 zone created statically to avoid invalid count argument error when creating records and zones simultaneously"
  value       = { for k, v in var.zones : k => lookup(v, "domain_name", k) if var.create }
}
