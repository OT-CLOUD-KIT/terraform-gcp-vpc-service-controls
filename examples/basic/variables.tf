variable "parent_id" {
  description = "Numeric Google Cloud organization ID."
  type        = string
}

variable "project_number" {
  description = "Project number for the project to protect."
  type        = string
}

variable "member" {
  description = "Example principal to allow at the access-level layer, such as user:someone@example.com."
  type        = string
}