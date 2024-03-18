resource "aws_iam_role" "lanchonete" {
  name = "eks-cluster-lanchonete"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "lanchonete-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.lanchonete.name
}

variable "cluster_name" {
  default = "lanchonete"
  type = string
  description = "AWS EKS Cluster Lanchonete"
  nullable = false
}

resource "aws_eks_cluster" "lanchonete" {
  name     = var.cluster_name
  role_arn = aws_iam_role.lanchonete.arn

  vpc_config {
    subnet_ids = [
      aws_subnet.private-us-east-1a.id,
      aws_subnet.private-us-east-1b.id,
      aws_subnet.public-us-east-1a.id,
      aws_subnet.public-us-east-1b.id
    ]
  }

  depends_on = [aws_iam_role_policy_attachment.lanchonete-AmazonEKSClusterPolicy]
}
