#!/bin/bash

# Add the AWS Load Balancer Controller Helm repo
helm repo add eks https://aws.github.io/eks-charts

# Update local repo cache
helm repo update

# Install the controller (replace <vpc-id> and <cluster-name>)
helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
    -n kube-system \
    --set clusterName=eks-portfolio-cluster \
    --set serviceAccount.create=false \
    --set serviceAccount.name=aws-load-balancer-controller \
    --set vpcId=vpc-0e2a189f1cad6ffbb \
    --set region=ap-south-1

