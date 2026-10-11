output "cluster_name" {
  description = "Name of the EKS cluster"
  value       = aws_eks_cluster.main.name
}

output "region" {
  description = "AWS region where the EKS cluster is deployed"
  value       = "eu-west-1"
}