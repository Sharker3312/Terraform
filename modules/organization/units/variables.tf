variable "root_id" {
  description = "AWS Organizations root ID to attach environment OUs under"
  type        = string
}

variable "environments" {
  description = "List of environments to create as OUs (e.g., dev, qa, prod)"
  type        = list(string)
}

variable "projects" {
  description = "Projects to create as child OUs under each environment"
  type        = list(string)
}

variable "env_name_style" {
  description = "Style for environment OU names: title|upper|lower"
  type        = string
  default     = "title"
  validation {
    condition     = contains(["title", "upper", "lower"], var.env_name_style)
    error_message = "env_name_style must be one of: title, upper, lower."
  }
}

variable "project_name_prefix" {
  description = "Prefix for project OU names"
  type        = string
  default     = "Project-"
}

variable "tags" {
  description = "Optional tags to add to OUs"
  type        = map(string)
  default     = {}
}