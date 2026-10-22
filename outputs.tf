output "policy_id" {
  description = "Fully qualified Access Context Manager policy resource name."
  value       = module.access_policy.policy_id
}

output "policy_name" {
  description = "Display name of the Access Context Manager policy."
  value       = module.access_policy.policy_name
}

output "access_level_ids" {
  description = "Map of wrapper access-level keys to fully qualified access-level resource names."
  value = {
    for key, level in module.access_level :
    key => level.name_id
  }
}

output "perimeter_names" {
  description = "Map of wrapper perimeter keys to the created perimeter names."
  value = {
    for key, perimeter in module.regular_perimeter :
    key => perimeter.perimeter_name
  }
}