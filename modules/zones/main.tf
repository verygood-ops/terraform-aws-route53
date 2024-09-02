locals {
  unique_zones = {
    for key, value in var.zones :
    "${key}_${sha256(jsonencode(value))}" => merge(value, { original_key = key })
  }
}

resource "aws_route53_zone" "this" {
  for_each = { for k, v in local.unique_zones : k => v if var.create }

  name          = each.key
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
