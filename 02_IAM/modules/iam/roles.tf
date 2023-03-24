variable "role_names" {
  default = []
}

# Create IAM roles using for_each loop
resource "aws_iam_role" "roles" {
  for_each = toset(var.role_names)
  name = each.value

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}
