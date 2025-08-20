AWS Load Balancer Controller (ALB) Setup
This folder contains resources to install and configure the AWS Load Balancer Controller on an EKS cluster. The controller provisions Application Load Balancers (ALBs) for Kubernetes Ingress resources.
________________________________________
Files
•	iam_policy.json – IAM policy for the controller. Grants permissions to manage ALBs, target groups, listeners, and related AWS resources.
•	install-alb-controller.sh – Script to install the controller using Helm and kubectl.
________________________________________
Prerequisites
Before installing the controller:
•	EKS cluster is running (Fargate or Node Group).
•	AWS CLI configured (aws configure).
•	kubectl installed.
•	Helm installed.
•	OIDC provider enabled on the cluster:
eksctl utils associate-iam-oidc-provider --region <region> --cluster <cluster-name> --approve
________________________________________
Setup Steps
1. Create IAM Policy
Download the policy or use the included file:
aws iam create-policy \
  --policy-name AWSLoadBalancerControllerIAMPolicy \
  --policy-document file://controller/iam_policy.json
2. Create IAM Service Account
eksctl create iamserviceaccount \
  --cluster eks-portfolio-cluster \
  --namespace kube-system \
  --name aws-load-balancer-controller \
  --attach-policy-arn arn:aws:iam::<ACCOUNT_ID>:policy/AWSLoadBalancerControllerIAMPolicy \
  --approve
If the service account exists, use --override-existing-serviceaccounts to update it.
3. Install Controller
bash install-alb-controller.sh
________________________________________
Verify Installation
kubectl get pods -n kube-system | grep aws-load-balancer-controller
Ensure pods are in Running state.
________________________________________
Notes / Troubleshooting
•	If ServiceAccount creation fails:
o	Ensure the IAM OIDC provider exists.
o	Check the IAM policy ARN is correct.
•	If Helm installation fails due to name conflict:
helm list -A
Uninstall previous release if needed:
helm uninstall aws-load-balancer-controller -n kube-system
•	Replace placeholders like your-vpc-id and cluster-name in the script with actual values.
•	For high availability, run 2 replicas of the controller across multiple AZs.
________________________________________
References
•	https://github.com/kubernetes-sigs/aws-load-balancer-controller
•	https://docs.aws.amazon.com/eks/latest/userguide/alb-ingress.html

