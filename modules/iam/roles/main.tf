data "aws_iam_policy_document" "assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.identity_account_id}:root"]
    }
  }
}

# ===== Role: Backend RDS ReadOnly (policy: ../policies/rds-read.json) =====
resource "aws_iam_role" "backend_rds_readonly" {
  name               = "${var.role_name_prefix}Backend-RDSReadOnly"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  tags               = merge(var.tags, { Team = "Backend", Service = "RDS", Capability = "ReadOnly" })
}

resource "aws_iam_policy" "backend_rds_readonly" {
  name   = "${var.role_name_prefix}Backend-RDSReadOnly"
  policy = file("${path.module}/../policies/rds-read.json")
}

resource "aws_iam_role_policy_attachment" "backend_rds_readonly" {
  role       = aws_iam_role.backend_rds_readonly.name
  policy_arn = aws_iam_policy.backend_rds_readonly.arn
}

# ===== Role: Frontend Amplify (policy: ../policies/amplify-deploy.json) =====
resource "aws_iam_role" "frontend_amplify" {
  name               = "${var.role_name_prefix}Frontend-Amplify"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  tags               = merge(var.tags, { Team = "Frontend", Service = "Amplify" })
}

resource "aws_iam_policy" "frontend_amplify" {
  name   = "${var.role_name_prefix}Frontend-Amplify"
  policy = file("${path.module}/../policies/amplify-deploy.json")
}

resource "aws_iam_role_policy_attachment" "frontend_amplify" {
  role       = aws_iam_role.frontend_amplify.name
  policy_arn = aws_iam_policy.frontend_amplify.arn
}
