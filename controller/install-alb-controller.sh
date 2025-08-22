#!/bin/bash

# Add the AWS Load Balancer Controller Helm repo
helm repo add eks https://aws.github.io/eks-charts

# Update local repo cache
helm repo update

# Install the controller (replace <cluster-name> if you are using different name)
VPC_ID=$(aws eks describe-cluster \
  --name eks-portfolio-cluster \
  --region ap-south-1 \
  --query "cluster.resourcesVpcConfig.vpcId" \
  --output text)

helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
  -n kube-system \
  --set clusterName=eks-portfolio-cluster \
  --set serviceAccount.create=false \
  --set serviceAccount.name=aws-load-balancer-controller \
  --set vpcId=$VPC_ID \
  --set region=ap-south-1

