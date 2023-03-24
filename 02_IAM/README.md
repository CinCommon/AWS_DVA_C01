## 1. I want to add some users and roles by terraform, could you give me the file structure and code?
Sure! Here is an example Terraform code to create users and roles in AWS:

```terraform
# Define the provider (in this case, AWS)
provider "aws" {
  region = "us-west-2"
}

# Create an IAM user
resource "aws_iam_user" "example_user" {
  name = "example_user"
}

# Create an IAM role
resource "aws_iam_role" "example_role" {
  name = "example_role"

  assume_role_policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# Attach a policy to the role
resource "aws_iam_role_policy_attachment" "example_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  role       = aws_iam_role.example_role.name
}

# Create a user and add them to a group
resource "aws_iam_group" "example_group" {
  name = "example_group"
}

resource "aws_iam_group_membership" "example_membership" {
  name  = aws_iam_user.example_user.name
  group = aws_iam_group.example_group.name
  users = []
}
```

This code creates an IAM user named `example_user`, an IAM role named `example_role`, and an IAM group named `example_group`. The user is added to the group, and a policy is attached to the role. You can modify the names and policies to fit your specific use case.

The file structure is up to you, but typically you would organize Terraform code into modules and put them in a separate directory. Here is an example file structure:

```css
.
├── main.tf
├── variables.tf
└── modules
    └── iam
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

In this example, the `main.tf` file in the root directory contains the code to call the IAM module. The `variables.tf` file contains the variable declarations. The `modules` directory contains the IAM module, which has its own `main.tf`, `variables.tf`, and `outputs.tf` files.

To use this file structure, you would call the IAM module like this:


```terraform
module "iam" {
  source = "./modules/iam"
  # Declare any module-specific variables here
}
```
Make sure to modify the source parameter to match the location of your module.


