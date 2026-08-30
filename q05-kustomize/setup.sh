#!/bin/bash
# Deploys the starting state (as the question describes it already deployed).
set -e
DIR=$(dirname "$0")
kubectl create ns api-gateway-staging --dry-run=client -o yaml | kubectl apply -f -
kubectl create ns api-gateway-prod --dry-run=client -o yaml | kubectl apply -f -
kubectl kustomize "$DIR/staging" | kubectl apply -f -
kubectl kustomize "$DIR/prod" | kubectl apply -f -
mkdir -p /course/5
cp -r "$DIR"/* /course/5/ 2>/dev/null || echo "Copy $DIR to wherever you want /course/5/api-gateway to live."
echo "Deployed. Now edit the kustomize config at /course/5/api-gateway per the question."
