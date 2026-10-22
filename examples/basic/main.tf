module "vpc_service_controls" {
  source = "../../"

  parent_id   = var.parent_id
  policy_name = "example-vpc-service-controls"

  access_levels = {
    demo_members = {
      members = [var.member]
    }
  }

  perimeters = {
    demo_perimeter = {
      perimeter_name = "demo_regular_perimeter"
      description    = "Demonstration perimeter for selected services"

      resources = [
        "projects/${var.project_number}"
      ]

      restricted_services = [
        "bigquery.googleapis.com",
        "storage.googleapis.com"
      ]

      access_level_keys = ["demo_members"]

      # Start with no directional rules. Add narrowly scoped rules
      # only after reviewing the service's actual access requirements.
      ingress_policies = {}
      egress_policies  = {}
    }
  }

  # Keep false for the initial validation phase.
  # Set true only after confirming organization permissions and scope.
  enable_perimeters = false
}

output "policy_id" {
  value = module.vpc_service_controls.policy_id
}

output "access_level_ids" {
  value = module.vpc_service_controls.access_level_ids
}

output "perimeter_names" {
  value = module.vpc_service_controls.perimeter_names
}