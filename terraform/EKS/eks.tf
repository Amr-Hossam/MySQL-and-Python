resource "aws_iam_role" "eks_cluster" {

  name = "eks-cluster"
  
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

# Attach the AWS EKS service and AWS EKS cluster policies to the role.

resource "aws_iam_role_policy_attachment" "eks-cluster-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster.name
}

resource "aws_eks_cluster" "eks" {
  name = "eks"
  role_arn = aws_iam_role.eks_cluster.arn
  vpc_config {
    endpoint_private_access = false
    endpoint_public_access = true
    subnet_ids = [var.public1_subnet_id,var.public2_subnet_id]
  }
  depends_on = [
    aws_iam_role_policy_attachment.eks-cluster-AmazonEKSClusterPolicy
  ]
}
