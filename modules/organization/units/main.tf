locals {
  env_labels = {
    for e in var.environments :
    e => (
      var.env_name_style == "upper" ? upper(e) :
      var.env_name_style == "lower" ? lower(e) :
      title(e)
    )
  }

  project_pairs = flatten([
    for e in var.environments : [
      for p in var.projects : {
        env     = e
        project = p
      }
    ]
  ])
}

# ROOT -> Environment
resource "aws_organizations_organizational_unit" "env" {
  for_each = local.env_labels

  name      = each.value
  parent_id = var.root_id

  tags = merge(var.tags, {
    Scope = "Environment"
    Env   = each.key
  })
}

# Environment -> Project
resource "aws_organizations_organizational_unit" "project" {
  for_each = {
    for pair in local.project_pairs :
    "${pair.env}/${pair.project}" => pair
  }

  name      = "${var.project_name_prefix}${title(each.value.project)}"
  parent_id = aws_organizations_organizational_unit.env[each.value.env].id

  tags = merge(var.tags, {
    Scope   = "Project"
    Env     = each.value.env
    Project = each.value.project
  })
}