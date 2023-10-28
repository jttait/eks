#! /bin/bash

#
# CREATE INFRASTRUCTURE
# 

terraform -chdir=infrastructure apply

export ECR_REPOSITORY_URL=$(terraform -chdir=infrastructure output -raw ecr_repository_url)
export REGION=$(terraform -chdir=infrastructure output -raw region)
export CLUSTER_NAME=$(terraform -chdir=infrastructure output -raw cluster_name)

aws eks --region $REGION update-kubeconfig --name $CLUSTER_NAME

helm upgrade --install ingress-nginx ingress-nginx \
	--repo https://kubernetes.github.io/ingress-nginx \
	--namespace ingress-nginx --create-namespace

#
# BUILD APPLICATION
#

sudo systemctl start docker
aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin $ECR_REPOSITORY_URL
docker buildx build --tag testserver ./app/
docker tag testserver:latest "$ECR_REPOSITORY_URL:latest"
docker push "$ECR_REPOSITORY_URL:latest"

#
# DEPLOY APPLICATION
#

helm upgrade --install testserver ./app/helm/ \
	--namespace testserver --create-namespace \
	--set image.repository=$ECR_REPOSITORY_URL

