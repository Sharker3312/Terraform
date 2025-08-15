resource "aws_organizations_organization" "this" {
  feature_set = "ALL"
}

data "aws_organizations_organization" "current" {
  depends_on = [aws_organizations_organization.this]
}