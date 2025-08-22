________________________________________
AWS Load Balancer Controller on EKS

This guide explains how to install and configure the AWS Load Balancer Controller on an EKS cluster.
________________________________________
Prerequisites

Before installing the controller, make sure you have:

•	An EKS cluster running (Fargate or Node Group)
•	AWS CLI configured (aws configure)
•	kubectl installed
•	Helm installed
•	OIDC provider enabled on the cluster

eksctl utils associate-iam-oidc-provider \
  --region `<region>` \
  --cluster `<cluster-name>` \
  --approve
  
________________________________________

Step 1: Create IAM Policy

Download the IAM policy file and create the policy.

curl -o iam_policy.json https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/main/docs/install/iam_policy.json

aws iam create-policy \
  --policy-name AWSLoadBalancerControllerIAMPolicy \
  --policy-document file://iam_policy.json
________________________________________

Step 2: Create IAM Role for Service Account.

Use eksctl to create the IAM role and attach the policy.

eksctl create iamserviceaccount \
  --cluster=eks-portfolio-cluster \
  --namespace=kube-system \
  --name=aws-load-balancer-controller \
  --attach-policy-arn=arn:aws:iam::<account-id>:policy/AWSLoadBalancerControllerIAMPolicy \
  --override-existing-serviceaccounts \
  --approve

________________________________________

Step 3: Install the AWS Load Balancer Controller via Helm

helm repo add eks https://aws.github.io/eks-charts
helm repo update

helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
  -n kube-system \
  --set clusterName=eks-portfolio-cluster \
  --set serviceAccount.create=false \
  --set serviceAccount.name=aws-load-balancer-controller
________________________________________

Step 4: Verify the Installation

kubectl get deployment -n kube-system aws-load-balancer-controller

Expected output should show the deployment with replicas in Running state.
