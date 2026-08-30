#!/bin/bash
# Installs Gateway API CRDs + NGINX Gateway Fabric (a real controller, so
# curl tests actually work), then deploys the namespace/services/Gateway
# and drops the old Ingress YAML for you to convert.
set -e

# 1. Gateway API CRDs (standard channel)
kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.2.0/standard-install.yaml

# Remove old NGINX Gateway Fabric CRDs to avoid storedVersions conflicts
kubectl delete crd \
  clientsettingspolicies.gateway.nginx.org \
  nginxgateways.gateway.nginx.org \
  nginxproxies.gateway.nginx.org \
  observabilitypolicies.gateway.nginx.org \
  --ignore-not-found

# 2. NGINX Gateway Fabric (controller + GatewayClass)
kubectl apply -f https://raw.githubusercontent.com/nginx/nginx-gateway-fabric/v1.5.0/deploy/crds.yaml
kubectl apply -f https://raw.githubusercontent.com/nginx/nginx-gateway-fabric/v1.5.0/deploy/default/deploy.yaml

# 3. App namespace, backend services, and the Gateway itself
DIR=$(dirname "$0")
kubectl apply -f "$DIR/app.yaml"

mkdir -p /course/13
cp "$DIR/ingress.yaml" /course/13/ingress.yaml 2>/dev/null || true

echo "Check: kubectl -n nginx-gateway get svc   (note the NodePort, may not be exactly 30080)"
echo "Update /etc/hosts on your test box: <node-ip> r500.gateway"
