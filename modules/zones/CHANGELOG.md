# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [4.0.1] - 2024-08-30
### Changed
- Updated `aws_route53_zone` resource configuration to handle multiple hosted zones with the same domain name by modifying the `for_each` key to include the `vpc_id` where applicable.
- Programmatically updated the Terraform state to reflect the new `for_each` keys, preventing resource recreation.

## [4.0.0] - 2024-08-30
Points to the upstream tag without changes https://github.com/terraform-aws-modules/terraform-aws-route53/releases/tag/v4.0.0
