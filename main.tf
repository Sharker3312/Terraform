# Organization (creates the AWS Organization and exposes root_id)
module "organization" {
  source = "./modules/organization"

  organization_name = var.organization_name
}

# Organizational Units (ROOT -> Env -> Project)
module "organizational_units" {
  source = "./modules/organization/units"

  root_id      = module.organization.root_id
  environments = var.environments
  projects     = var.projects
}

module "iam_roles" {
  source              = "./modules/iam/roles"
  identity_account_id = var.identity_account_id
  role_name_prefix    = "Team-"
  tags = {
    ManagedBy = "Terraform"
  }
}

# Next modules (to be added later):
# - Accounts: ./modules/organization/accounts
# - IAM roles: ./modules/iam/roles
# Use module.organizational_units.ous for parent OU IDs.

