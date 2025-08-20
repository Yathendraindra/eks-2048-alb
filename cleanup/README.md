# Cleanup Scripts

This folder contains scripts to delete the EKS cluster and associated AWS resources for the portfolio project.

## Files

- `delete-cluster.sh` – Script to delete the EKS cluster created via eksctl along with its Fargate profiles.

## Usage

1. Make sure your AWS CLI is configured and you have permissions to delete EKS clusters.
2. Run the script:

```bash
bash delete-cluster.sh

------

Monitor deletion in AWS console. Some AWS resources like Load Balancers or IAM roles may take additional time to delete.

Optional: Manually remove any stuck AWS resources using the CLI.