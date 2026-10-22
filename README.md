# terraform-gcp-vpc-service-controls

Reusable Terraform wrapper for Google Cloud VPC Service Controls and
Access Context Manager.

## Features

- Create an Access Context Manager access policy.
- Configure access levels.
- Create regular service perimeters.
- Configure protected project resources.
- Restrict selected Google Cloud services.
- Configure optional ingress and egress policies.
- Reuse the official Terraform Google VPC Service Controls module.

## Requirements

- Terraform >= 1.3.0
- Google provider >= 8.0.0, < 9.0.0
- Google Cloud organization and appropriate Access Context Manager permissions
- Access Context Manager API enabled

## Usage

```hcl
module "vpc_service_controls" {
  source  = "git::https://github.com/OT-CLOUD-KIT/terraform-gcp-vpc-service-controls.git?ref=v1.0.0"

  parent_id   = var.organization_id
  policy_name = "example-vpc-service-controls"

  access_levels = {
    demo_members = {
      members = ["user:example@example.com"]
    }
  }

  perimeters = {
    demo_perimeter = {
      perimeter_name = "demo_regular_perimeter"
      description    = "Example perimeter"

      resources = [
        "projects/123456789012"
      ]

      restricted_services = [
        "bigquery.googleapis.com",
        "storage.googleapis.com"
      ]

      access_level_keys = ["demo_members"]
    }
  }

  enable_perimeters = false
}