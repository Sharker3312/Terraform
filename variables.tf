variable "organization_name" {
  description = "AWS Organization name"
  type        = string
  default     = "SoloME INC"
}

variable "primary_region" {
  description = "Primary AWS region"
  type        = string
  default     = "us-east-1"
}

variable "identity_account_id" {
  description = "AWS Account ID where IAM users/groups live"
  type        = string
  default     = null

  validation {
    condition     = var.identity_account_id == null || can(regex("^[0-9]{12}$", var.identity_account_id))
    error_message = "identity_account_id must be null or a valid 12-digit AWS Account ID."
  }
}

# Environments configuration
variable "environments" {
  description = "List of environments to create"
  type        = list(string)
  # Aligned with env/{dev,qa,prod}
  default = ["dev", "qa", "prod"]

  validation {
    condition     = length(var.environments) > 0 && alltrue([for e in var.environments : can(regex("^[a-z0-9-]+$", e))])
    error_message = "Each environment must be non-empty and in kebab-case (e.g., dev, qa, prod)."
  }
}

# Projects configuration
variable "projects" {
  description = "List of projects/applications"
  type        = list(string)
  default     = ["ecommerce", "analytics", "mobile-app"]
}

# Teams configuration
variable "teams" {
  description = "Teams and members configuration"
  type = map(object({
    members     = list(string)
    description = string
    permissions = list(string)
  }))
  default = {
    devops = {
      members     = ["devops@company.com"]
      description = "DevOps and Infrastructure Team"
      permissions = ["infrastructure", "security", "monitoring"]
    }
    backend = {
      members     = ["backend@company.com"]
      description = "Backend Development Team"
      permissions = ["applications", "databases", "apis"]
    }
    frontend = {
      members     = ["frontend@company.com"]
      description = "Frontend Development Team"
      permissions = ["static-assets", "cdn", "ui-logs"]
    }
    finops = {
      members     = ["finops@company.com"]
      description = "Financial Operations Team"
      permissions = ["cost-management", "billing", "optimization"]
    }
  }
}

/* # AWS accounts per environment and project
variable "account_config" {
  description = "AWS accounts configuration to create"
  type = map(object({
    email       = string
    environment = string
    project     = optional(string)
    ou_path     = string
  }))
  default = {
    # Core accounts
    "log-archive" = {
      email       = "log-archive@company.com"
      environment = "core"
      ou_path     = "Core"
    }
    "audit" = {
      email       = "audit@company.com"
      environment = "core"
      ou_path     = "Core"
    }
    "security" = {
      email       = "security@company.com"
      environment = "core"
      ou_path     = "Core"
    }

    # Dev accounts
    "ecommerce-dev" = {
      email       = "ecommerce-dev@company.com"
      environment = "dev"
      project     = "ecommerce"
      ou_path     = "Dev/Project-ECommerce"
    }
    "analytics-dev" = {
      email       = "analytics-dev@company.com"
      environment = "dev"
      project     = "analytics"
      ou_path     = "Dev/Project-Analytics"
    }

    # QA accounts
    "ecommerce-qa" = {
      email       = "ecommerce-qa@company.com"
      environment = "qa"
      project     = "ecommerce"
      ou_path     = "QA/Project-ECommerce"
    }

    # Prod accounts
    "ecommerce-prod" = {
      email       = "ecommerce-prod@company.com"
      environment = "prod"
      project     = "ecommerce"
      ou_path     = "Prod/Project-ECommerce"
    }
    "analytics-prod" = {
      email       = "analytics-prod@company.com"
      environment = "prod"
      project     = "analytics"
      ou_path     = "Prod/Project-Analytics"
    }
  }

  # Validation: environment must be core or one of var.environments
  validation {
    condition = alltrue([
      for _, v in var.account_config :
      contains(concat(["core"], var.environments), v.environment)
    ])
    error_message = "Each account must have environment = core|dev|qa|prod (aligned with var.environments)."
  }
} */