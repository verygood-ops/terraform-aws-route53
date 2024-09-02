locals {
  # Create a map with unique keys by combining the domain name and a hash of the entire value
  unique_zones = {
    for key, value in var.zones :
    "${value.domain_name}_${sha256(jsonencode(value))}" => merge(value, { original_key = key })
  }
}

resource "aws_route53_zone" "this" {
  for_each = { for k, v in local.unique_zones : k => v if var.create }

  name          = v.domain_name
  comment       = lookup(v, "comment", null)
  force_destroy = lookup(v, "force_destroy", false)

  delegation_set_id = lookup(v, "delegation_set_id", null)

  dynamic "vpc" {
    for_each = try(tolist(lookup(v, "vpc", [])), [lookup(v, "vpc", {})])

    content {
      vpc_id     = vpc.value.vpc_id
      vpc_region = lookup(vpc.value, "vpc_region", null)
    }
  }

  tags = merge(
    lookup(v, "tags", {}),
    var.tags
  )
}
