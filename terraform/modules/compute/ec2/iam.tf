# Role for K3s
resource "aws_iam_role" "k3s_role" {
  name = "${var.project_name}_k3s_role"

  assume_role_policy = jsonencode({
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
  })

  tags = var.common_tags
}

# Allow K3s to read ECR to download images
resource "aws_iam_role_policy_attachment" "k3s_ecr_access" {
  role       = aws_iam_role.k3s_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSAppRunnerServicePolicyForECRAccess"
}

resource "aws_iam_instance_profile" "k3s_instance_profile" {
  name = "${var.project_name}_k3s_instance_profile"
  role = aws_iam_role.k3s_role.name
}