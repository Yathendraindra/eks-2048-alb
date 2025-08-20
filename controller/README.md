AWS Load Balancer Controller on EKS

This guide explains how to install and configure the AWS Load Balancer Controller on an EKS cluster.

Prerequisites

Before installing the controller, make sure you have:

An EKS cluster running (Fargate or Node Group)

AWS CLI configured (aws configure)

kubectl installed

Helm installed

OIDC provider enabled on the cluster

eksctl utils associate-iam-oidc-provider \
  --region `<region>` \
  --cluster `<cluster-name>` \
  --approve

Step 1: Create IAM Policy

Download the IAM policy file and create the policy.

curl -o iam_policy.json https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/main/docs/install/iam_policy.json

aws iam create-policy \
  --policy-name AWSLoadBalancerControllerIAMPolicy \
  --policy-document file://iam_policy.json

Step 2: Create IAM Role for Service Account

Use eksctl to create the IAM role and attach the policy.

eksctl create iamserviceaccount \
  --cluster=<cluster-name> \
  --namespace=kube-system \
  --name=aws-load-balancer-controller \
  --attach-policy-arn=arn:aws:iam::<account-id>:policy/AWSLoadBalancerControllerIAMPolicy \
  --override-existing-serviceaccounts \
  --approve

Step 3: Install the AWS Load Balancer Controller via Helm
helm repo add eks https://aws.github.io/eks-charts
helm repo update

helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
  -n kube-system \
  --set clusterName=<cluster-name> \
  --set serviceAccount.create=false \
  --set serviceAccount.name=aws-load-balancer-controller

Step 4: Verify the Installation
kubectl get deployment -n kube-system aws-load-balancer-controller


Expected output should show the deployment with replicas in Running state.

Step 5: Test with a Sample Application

Deploy an app with an Ingress resource:

kubectl apply -f 2048-deploy.yaml
kubectl apply -f 2048-ingress.yaml


Check the Ingress:

kubectl get ingress -n game-2048


You should see an ALB DNS name. Open it in a browser to confirm the app is accessible.
