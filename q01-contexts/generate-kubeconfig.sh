#!/bin/bash
# Recreates a kubeconfig with 3 contexts (cluster-admin, cluster-w100, cluster-w200)
# and a real client cert for user account-0027, so you can practice extracting
# context names / current-context / decoded cert.
set -e
OUT=${1:-./kubeconfig}
WORKDIR=$(mktemp -d)
cd "$WORKDIR"

# Generate a throwaway CA + client cert to stand in for account-0027
openssl genrsa -out ca.key 2048 -quiet
openssl req -x509 -new -nodes -key ca.key -subj "/CN=kubernetes" -days 3650 -out ca.crt -quiet
openssl genrsa -out client.key 2048 -quiet
openssl req -new -key client.key -subj "/CN=account-0027@internal" -out client.csr -quiet
openssl x509 -req -in client.csr -CA ca.crt -CAkey ca.key -CAcreateserial -days 365 -out client.crt -quiet

CA_DATA=$(base64 -w0 ca.crt)
CERT_DATA=$(base64 -w0 client.crt)
KEY_DATA=$(base64 -w0 client.key)

cat > "$OUT" << KCFG
apiVersion: v1
kind: Config
preferences: {}
clusters:
- name: cluster1
  cluster:
    server: https://10.30.110.30:6443
    certificate-authority-data: ${CA_DATA}
users:
- name: admin@internal
  user:
    client-certificate-data: ${CA_DATA}
    client-key-data: ${KEY_DATA}
- name: account-0027@internal
  user:
    client-certificate-data: ${CERT_DATA}
    client-key-data: ${KEY_DATA}
- name: account-0028@internal
  user:
    client-certificate-data: ${CA_DATA}
    client-key-data: ${KEY_DATA}
contexts:
- name: cluster-admin
  context:
    cluster: kubernetes
    user: admin@internal
- name: cluster-w100
  context:
    cluster: kubernetes
    user: account-0027@internal
- name: cluster-w200
  context:
    cluster: kubernetes
    user: account-0028@internal
current-context: cluster-w200
KCFG

rm -rf "$WORKDIR"
mkdir -p /course/1
cp "$OUT" /course/1/kubeconfig 2>/dev/null || echo "Note: /course/1 not writable here, kubeconfig written to $OUT — copy it to wherever you want the exercise to live."
echo "kubeconfig written to $OUT"
