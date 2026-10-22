variable "parent_id" {
  description = "Organization ID that owns the Access Context Manager policy."
  type        = string

  validation {
    condition     = can(regex("^[0-9]+$", var.parent_id))
    error_message = "parent_id must be a numeric Google Cloud organization ID."
  }
}

variable "policy_name" {
  description = "Display name for the Access Context Manager policy."
  type        = string
}

variable "scopes" {
  description = "Optional folder or project scopes, such as folders/123456 or projects/123456."
  type        = list(string)
  default     = []
}

variable "access_levels" {
  description = "Named access levels to create under the policy."
  type = map(object({
    members        = optional(list(string), [])
    ip_subnetworks = optional(list(string), [])
    regions        = optional(list(string), [])
  }))
  default = {}
}

variable "perimeters" {
  description = "Regular service perimeters keyed by a unique Terraform map key."
  type = map(object({
    perimeter_name      = string
    description         = optional(string, "")
    resources           = list(string)
    restricted_services = set(string)
    access_level_keys   = optional(set(string), [])
    ingress_policies    = optional(any, {})
    egress_policies     = optional(any, {})
  }))
  default = {}
}

variable "enable_perimeters" {
  description = "Safety switch. Keep false while demonstrating and validating access policy configuration."
  type        = bool
  default     = false
}