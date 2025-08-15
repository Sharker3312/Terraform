output "organization_id" {
  description = "AWS Organization ID"
  value       = data.aws_organizations_organization.current.id
}

output "root_id" {
  description = "AWS Organization root ID"
  value       = data.aws_organizations_organization.current.roots[0].id
}