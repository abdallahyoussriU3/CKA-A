#!/bin/bash
# Prep for Q2: adds the jetstack helm repo (cert-manager is NOT installed —
# that's your task) and drops the ClusterIssuer YAML you need to edit.
set -e
helm repo add jetstack https://charts.jetstack.io 2>/dev/null || true
helm repo update
mkdir -p /course/2
cp "$(dirname "$0")/cluster-issuer.yaml" /course/2/cluster-issuer.yaml
echo "jetstack repo added, cluster-issuer.yaml placed at /course/2/cluster-issuer.yaml"
echo "Your task: create ns cert-manager, helm install the chart (crds.enabled=true),"
echo "add spec.selfSigned.crlDistributionPoints to the ClusterIssuer, then apply it."
