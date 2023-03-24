output "user_names" {
  value = aws_iam_user.users[*].name
}

output "role_names" {
  value = aws_iam_role.roles[*].name
}

output "role_arns" {
  value = aws_iam_role.roles[*].arn
}
