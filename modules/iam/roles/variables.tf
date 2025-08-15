variable "identity_account_id" {
  description = "12-digit AWS account ID allowed to assume these roles"
  type        = string

  validation {
    condition     = can(regex("^[0-9]{12}$", var.identity_account_id))
    error_message = "identity_account_id must be a valid 12-digit AWS Account ID."
  }
}

variable "role_name_prefix" {
  description = "Prefix for role names"
  type        = string
  default     = "Team-"
}

variable "tags" {
  description = "Tags to add to roles"
  type        = map(string)
  default     = {}
}