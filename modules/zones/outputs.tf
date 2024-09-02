output "route53_zone_zone_id" {
  description = "Zone ID of Route53 zone"
  value       = { for k, v in local.unique_zones : k => aws_route53_zone.this[k].zone_id }
}

output "route53_zone_zone_arn" {
  description = "Zone ARN of Route53 zone"
  value       = { for k, v in local.unique_zones : k => aws_route53_zone.this[k].arn }
}

output "route53_zone_name_servers" {
  description = "Name servers of Route53 zone"
  value       = { for k, v in local.unique_zones : k => aws_route53_zone.this[k].name_servers }
}

output "primary_name_server" {
  description = "The Route 53 name server that created the SOA record."
  value       = { for k, v in local.unique_zones : k => aws_route53_zone.this[k].primary_name_server }
}

output "route53_zone_name" {
  description = "Name of Route53 zone"
  value       = { for k, v in local.unique_zones : k => aws_route53_zone.this[k].name }
}

output "route53_static_zone_name" {
  description = "Name of Route53 zone created statically to avoid invalid count argument error when creating records and zones simultaneously"
  value       = { for k, v in local.unique_zones : k => v.domain_name if var.create }
}
