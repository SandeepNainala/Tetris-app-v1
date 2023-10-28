resource "aws_iam_role" "test_role" {
  name = "Jenkins-terraform"

  assume_role_policy = <<EOF
    {
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  }
  EOF
}

resource "aws_iam_group_policy_attachment" "test_attachment" {
  role       = aws_iam_role.test_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_instance_profile" "test_profile" {
  name  = "Jenkins-terraform"
  role  = aws_iam_role.test_role.name
}
