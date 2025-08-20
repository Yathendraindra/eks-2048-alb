# Prerequisites for Running the 2048 EKS Project

Before you start, make sure you have the following installed and configured:

## 1. AWS CLI
- Install AWS CLI v2: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
- Configure your credentials:

```bash
aws configure

2. kubectl

Install kubectl: https://kubernetes.io/docs/tasks/tools/

Ensure your version is compatible with the EKS cluster.

3. eksctl

Install eksctl: https://eksctl.io/introduction/#installation

Required to create EKS clusters quickly.

4. helm (for AWS Load Balancer Controller)

Install Helm: https://helm.sh/docs/intro/install/

Used to deploy the ALB ingress controller.

5. Git

Install Git: https://git-scm.com/

Needed to clone this repository and manage version control.

Optional

A web browser to access the 2048 game once the ALB Ingress is ready.