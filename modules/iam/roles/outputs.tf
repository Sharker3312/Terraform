output "backend_rds_readonly_role_arn" {
  description = "Backend RDS read-only role ARN"
  value       = aws_iam_role.backend_rds_readonly.arn
}

output "frontend_amplify_role_arn" {
  description = "Frontend Amplify role ARN"
  value       = aws_iam_role.frontend_amplify.arn
}

output "roles_by_team" {
  description = "Map of team -> role ARN"
  value = {
    backend  = aws_iam_role.backend_rds_readonly.arn
    frontend = aws_iam_role.frontend_amplify.arn
  }
}