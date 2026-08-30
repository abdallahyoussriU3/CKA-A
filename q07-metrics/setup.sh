#!/bin/bash
# Installs metrics-server so `kubectl top` works (question states it's
# already installed -- this recreates that precondition).
set -e
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
# Most single/multi-node kubeadm labs need --kubelet-insecure-tls since
# there's no real signed kubelet serving cert chain. Patch it in:
kubectl -n kube-system patch deployment metrics-server --type='json' \
  -p='[{"op":"add","path":"/spec/template/spec/containers/0/args/-","value":"--kubelet-insecure-tls"}]'
mkdir -p /course/7
echo "metrics-server installed. Give it ~30-60s, then 'kubectl top node' should work."
