aws cloudformation deploy \
  --template-file /Users/doctor/gitrepo/SRE_SLO_Demo_Back/cloudformation/main.yaml \
  --stack-name sre-slo-demo-v2 \
  --capabilities CAPABILITY_NAMED_IAM \
  --parameter-overrides \
    AppImage=640388149711.dkr.ecr.us-east-1.amazonaws.com/sre-app-v2:latest \
    PromImage=640388149711.dkr.ecr.us-east-1.amazonaws.com/sre-prometheus-v2:latest \
    GrafanaImage=640388149711.dkr.ecr.us-east-1.amazonaws.com/sre-grafana-v2:latest