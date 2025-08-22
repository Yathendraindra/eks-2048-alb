# EKS 2048 Game with AWS ALB Ingress

This project deploys the classic **2048 game** on an Amazon EKS cluster, fronted by an AWS Application Load Balancer (ALB) via Ingress.

---

## Prerequisites

Before starting, ensure you have:

- AWS account with permissions to create EKS clusters and IAM roles  
- eksctl installed  
- kubectl installed and configured  
- awscli installed  
- AWS Load Balancer Controller configured (IAM roles + Helm install)  

---

## Deployment Steps

### 1. Create EKS Cluster
Use eksctl to create the cluster from the provided configuration file:


$ eksctl create cluster -f cluster/cluster-eksctl.yml


### 2. Configure kubectl
Make sure your local kubectl is pointed to the new cluster:


$ aws eks update-kubeconfig --region <region> --name <cluster-name>


### 3. Install AWS Load Balancer Controller

The ALB controller is required for ingress.  


From the `controller/` folder, run the provided script and apply additional manifests:

$ bash install-alb-controller.sh


$kubectl apply -f controller/iam-policy.json # IAM policy (if needed via IRSA)


$kubectl apply -f controller/ingressclass-alb.yml


(If Helm is used, follow AWS docs to install the ALB controller.)

### 4. Create Namespace

All resources for the game will run in a dedicated namespace:

$ kubectl apply -f manifests/namespace.yml


### 5. Deploy Application, Service, and Ingress
Apply the app manifests (deployment, service, ingress):

$kubectl apply -f manifests/

### 6. Verify Pods
Check if all pods are running in the namespace:

$ kubectl get pods -n game-2048


### 7. Check Service and Ingress
Confirm that the service and ingress were created successfully:

$ kubectl get svc,ingress -n game-2048


### 8. Access the Game

Find the ALB DNS from the ingress output and open in browser:

http://LoadBalancerDNS  -- Replace with your own Load Balancer DNS


You should now see the 2048 game running 🎉

---

## Cleanup

To remove all resources:

Option 1 – Delete manifests manually:

$kubectl delete -f manifests/

$kubectl delete -f controller/ingressclass-alb.yml


Option 2 – Delete entire cluster:

Tip: Delete load balancer manually from AWS Console if script execution fails. Path: AWS --> EC2 --> LoadBalancer - you will find load balancer.

$ bash /cleanup/delete-cluster.sh


This will remove the EKS cluster and all associated resources.
