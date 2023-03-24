# List of user and role names
variable "user_names" {
  description = "Users name"
}

# Create IAM users using count parameter
resource "aws_iam_user" "users" {
  count = length(var.user_names)
  name = var.user_names[count.index]
}
