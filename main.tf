module "access_policy" {
  source  = "terraform-google-modules/vpc-service-controls/google"
  version = "8.0.0"

  parent_id   = var.parent_id
  policy_name = var.policy_name
  scopes      = var.scopes
}

module "access_level" {
  source  = "terraform-google-modules/vpc-service-controls/google//modules/access_level"
  version = "8.0.0"

  for_each = var.access_levels

  policy = module.access_policy.policy_id
  name   = each.key

  members        = each.value.members
  ip_subnetworks = each.value.ip_subnetworks
  regions        = each.value.regions
}

module "regular_perimeter" {
  source  = "terraform-google-modules/vpc-service-controls/google//modules/regular_service_perimeter"
  version = "8.0.0"

  for_each = var.enable_perimeters ? var.perimeters : {}

  policy         = module.access_policy.policy_id
  perimeter_name = each.value.perimeter_name
  description    = each.value.description

  resources           = each.value.resources
  restricted_services = sort(tolist(each.value.restricted_services))

  access_levels = [
    for key in each.value.access_level_keys :
    module.access_level[key].name_id
  ]

  ingress_policies = each.value.ingress_policies
  egress_policies  = each.value.egress_policies

  depends_on = [
    module.access_level
  ]
}