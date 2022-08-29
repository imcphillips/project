# Role
resource "aws_iam_role" "prod-ci-role" {
  name = "prod-ci-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          AWS = "594924685971"
        }
        Effect = "Allow"
      },
    ]
  })
}

# Policy
resource "aws_iam_policy" "prod-ci-policy" {
  name        = "prod-ci-policy"
  description = ""

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
        ]
        Effect   = "Allow"
        Resource = "arn:aws:iam::594924685971:role/prod-ci-role"
      },
    ]
  })
}

# Group
resource "aws_iam_group" "prod-ci-group" {
  name = "prod-ci-group"
  path = "/users/"
}

# Group-policy attachment
resource "aws_iam_group_policy_attachment" "prod-ci-group-policy-attachment" {
  group      = aws_iam_group.prod-ci-group.name
  policy_arn = aws_iam_policy.prod-ci-policy.arn
}

# User
resource "aws_iam_user" "prod-ci-user" {
  name = "prod-ci-user"
  path = "/users/"
}

# User-group membership
resource "aws_iam_group_membership" "prod-ci-group-membership" {
  name = "prod-ci-group-membership"
  users = [
    aws_iam_user.prod-ci-user.name
  ]
  group = aws_iam_group.prod-ci-group.name
}
