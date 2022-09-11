#!/usr/bin/env bash

set -eo pipefail
set -u

# Install the components needed to support HPA-class autoscaling 
kubectl apply -f https://github.com/knative/serving/releases/download/knative-v1.7.1/serving-hpa.yaml

# Enable automatic TLS certificates provisioning using Encrypt HTTP01 challenges

kubectl apply -f https://github.com/knative/net-http01/releases/download/knative-v1.7.0/release.yaml

kubectl patch configmap/config-network \
  --namespace knative-serving \
  --type merge \
  --patch '{"data":{"certificate-class":"net-http01.certificate.networking.knative.dev"}}'

kubectl patch configmap/config-network \
  --namespace knative-serving \
  --type merge \
  --patch '{"data":{"auto-tls":"Enabled"}}'
