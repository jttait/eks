# Elastic Kubernetes Service

Create EKS cluster and deploy simple server

## Prerequisites

- Docker
- Docker buildx plugin
- AWS CLI
- Terraform
- Helm

## Create

./run.sh

curl http://{LoadBalancerDNS}/testpath

## Destroy

terraform chdir=infrastructure destroy

It seems to not work. When it gets stuck deleting the subnets, etc then manually delete the load
balancer, then wait a minute or so, then delete the VPC.
