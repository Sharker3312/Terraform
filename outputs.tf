output "organization_id" {
  description = "AWS Organization ID"
  value       = module.organization.organization_id
}

output "organization_root_id" {
  description = "Root ID of the AWS Organization"
  value       = module.organization.root_id
}

output "organizational_units" {
  description = "Created OUs grouped by environments and projects"
  value       = module.organizational_units.ous
}

output "env_ou_ids" {
  description = "Environment OU IDs"
  value       = module.organizational_units.env_ou_ids
}

output "project_ou_ids" {
  description = "Project OU IDs keyed by env/project"
  value       = module.organizational_units.project_ou_ids
}

/* utput "accounts" {
  description = "Información de las cuentas creadas"
  value       = module.accounts.accounts
  sensitive   = true
}

output "cross_account_roles" {
  description = "ARNs de los roles cross-account creados"
  value       = module.iam_roles.cross_account_roles
} */