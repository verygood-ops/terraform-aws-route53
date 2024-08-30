locals {
  # Create a map with unique keys by adding a suffix to duplicate domain names
  unique_zones = {
    for idx, zone in flatten([
      for key, value in var.zones : {
        key   = key
        value = value
      }
    ]) :
    "${zone.key}_${idx}" => merge(zone.value, { original_key = zone.key })
  }
}

resource "aws_route53_zone" "this" {
  for_each = { for k, v in local.unique_zones : k => v if var.create }

  name          = lookup(each.value, "domain_name", each.value.original_key)
  comment       = lookup(each.value, "comment", null)
  force_destroy = lookup(each.value, "force_destroy", false)

  delegation_set_id = lookup(each.value, "delegation_set_id", null)

  dynamic "vpc" {
    for_each = try(tolist(lookup(each.value, "vpc", [])), [lookup(each.value, "vpc", {})])

    content {
      vpc_id     = vpc.value.vpc_id
      vpc_region = lookup(vpc.value, "vpc_region", null)
    }
  }

  tags = merge(
    lookup(each.value, "tags", {}),
    var.tags
  )
}
