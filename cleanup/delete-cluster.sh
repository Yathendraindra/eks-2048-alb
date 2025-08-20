#!/bin/bash

# Delete the EKS cluster
eksctl delete cluster --name eks-portfolio-cluster --region ap-south-1

# Optional: cleanup AWS Load Balancers if deletion stuck
# aws elbv2 describe-load-balancers
# aws elbv2 delete-load-balancer --load-balancer-arn <arn>

echo "Cluster and associated resources cleanup initiated."
