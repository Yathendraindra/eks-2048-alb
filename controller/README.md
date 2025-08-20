# AWS Load Balancer Controller (ALB) Setup

This folder contains resources to install the **AWS Load Balancer Controller** in the EKS cluster. The controller provisions Application Load Balancers (ALBs) for Kubernetes Ingress resources.

## Files

- `iam_policy.json` – IAM policy required by the controller. Allows the controller to manage ALBs, target groups, and related AWS resources.
- `install-alb-controller.sh` – Script to install the controller using Helm and kubectl.

## Prerequisites

- EKS cluster is running
- AWS CLI configured (`aws configure`)
- kubectl installed
- helm installed
- OIDC provider enabled on the cluster

## Setup Steps

1. **Create IAM policy**
```bash
aws iam create-policy \
  --policy-name AWSLoadBalancerControllerIAMPolicy \
  --policy-document file://controller/iam_policy.json


2. Create IAM service account for ALB controller.

eksctl create iamserviceaccount \
  --cluster eks-portfolio-cluster \
  --namespace kube-system \
  --name aws-load-balancer-controller \
  --attach-policy-arn arn:aws:iam::<ACCOUNT_ID>:policy/AWSLoadBalancerControllerIAMPolicy \
  --approve

3. Install the controller

bash install-alb-controller.sh

4. Verify installation

kubectl get pods -n kube-system
# Look for aws-load-balancer-controller pods in Running state

Notes

Ensure the VPC ID in install-alb-controller.sh matches your EKS cluster VPC.

For high availability, the controller should have two replicas across multiple Availability Zones.

This setup is compatible with AWS Load Balancer Controller v2.11.0. Update the IAM policy and Helm chart if using a different version.