#!/bin/bash
set -e

ACCOUNT_ID=640388149711
REGION=us-east-1
ECR_BASE=$ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com

aws ecr create-repository --repository-name sre-app-v2 --region $REGION || true
aws ecr create-repository --repository-name sre-prometheus-v2 --region $REGION || true
aws ecr create-repository --repository-name sre-grafana-v2 --region $REGION || true

aws ecr get-login-password --region $REGION \
| docker login --username AWS --password-stdin $ECR_BASE

docker buildx build --platform linux/amd64 -t sre-app-v2 /Users/doctor/gitrepo/SRE_SLO_Demo_Back/docker/app --load
docker tag sre-app-v2:latest $ECR_BASE/sre-app-v2:latest
docker push $ECR_BASE/sre-app-v2:latest

docker buildx build --platform linux/amd64 -t sre-prometheus-v2 /Users/doctor/gitrepo/SRE_SLO_Demo_Back/docker/prometheus --load
docker tag sre-prometheus-v2:latest $ECR_BASE/sre-prometheus-v2:latest
docker push $ECR_BASE/sre-prometheus-v2:latest

docker buildx build --platform linux/amd64 -t sre-grafana-v2 /Users/doctor/gitrepo/SRE_SLO_Demo_Back/docker/grafana --load
docker tag sre-grafana-v2:latest $ECR_BASE/sre-grafana-v2:latest
docker push $ECR_BASE/sre-grafana-v2:latest

echo "V2 images pushed successfully 🚀"