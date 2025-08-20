# AWS Load Balancer Controller (ALB) Setup

This folder contains resources to install the **AWS Load Balancer Controller** in the EKS cluster. The controller provisions Application Load Balancers (ALBs) for Kubernetes Ingress resources.

## Files

- `iam_policy.json` – IAM policy required by the controller. This policy allows the controller to manage ALBs, target groups, and other AWS resources.
- `install-alb-controller.sh` – Script to install the controller using Helm and kubectl.

## Prerequisites

- EKS cluster is running
- AWS CLI configured with proper credentials - Hint: "aws configure" command
- kubectl installed
- helm installed
- OIDC provider enabled on the cluster

## Setup Steps

1. **Create IAM policy**

```bash
aws iam create-policy \
  --policy-name AWSLoadBalancerControllerIAMPolicy \
  --policy-document file://controller/iam_policy.json

2. Install the controller
bash install-alb-controller.sh

3. Verify installation
kubectl get pods -n kube-system
# Look for aws-load-balancer-controller pods in Running state

Notes:

Ensure the VPC ID in install-alb-controller.sh matches your EKS cluster VPC.

For high availability, the controller should have two replicas across multiple Availability Zones.

This setup is compatible with AWS Load Balancer Controller v2.11.0. Update the IAM policy and Helm chart if using a different version.

------


