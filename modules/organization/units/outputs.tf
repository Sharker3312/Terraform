output "env_ou_ids" {
  description = "Map of environment -> OU ID"
  value = {
    for env, ou in aws_organizations_organizational_unit.env :
    env => ou.id
  }
}

output "project_ou_ids" {
  description = "Map of env/project -> OU ID"
  value = {
    for k, ou in aws_organizations_organizational_unit.project :
    k => ou.id
  }
}

output "ous" {
  description = "Structured info of created OUs"
  value = {
    environments = {
      for env, ou in aws_organizations_organizational_unit.env :
      env => { id = ou.id, name = ou.name }
    }
    projects = {
      for k, ou in aws_organizations_organizational_unit.project :
      k => { id = ou.id, name = ou.name, parent_id = ou.parent_id }
    }
  }
}