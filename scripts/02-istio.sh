#!/usr/bin/env bash

set -eo pipefail
set -u

KNATIVE_NET_ISTIO_VERSION=${KNATIVE_NET_ISTIO_VERSION:-1.8.0}

kubectl apply -l knative.dev/crd-install=true -f https://github.com/knative/net-istio/releases/download/knative-v${KNATIVE_NET_ISTIO_VERSION}/istio.yaml


## INSTALL Istio
n=0
until [ $n -ge 2 ]; do
  kubectl apply -f https://github.com/knative/net-istio/releases/download/knative-v${KNATIVE_NET_ISTIO_VERSION}/istio.yaml > /dev/null && break
  n=$[$n+1]
  sleep 5
done
kubectl wait --for=condition=Established --all crd > /dev/null
kubectl wait pod --timeout=-1s --for=condition=Ready -l '!job-name' -n istio-system > /dev/null

## INSTALL NET Istio Controller
n=0
until [ $n -ge 2 ]; do
  kubectl apply -f https://github.com/knative/net-istio/releases/download/knative-v${KNATIVE_NET_ISTIO_VERSION}/net-istio.yaml > /dev/null && break
  n=$[$n+1]
  sleep 5
done
# deployment for net-contour gets deployed to namespace knative-serving
kubectl wait pod --timeout=-1s --for=condition=Ready -l '!job-name' -n knative-serving > /dev/null

# Configure DNS with sslip.io

kubectl apply -f https://github.com/knative/serving/releases/download/knative-v1.8.0/serving-default-domain.yaml

