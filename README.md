# CKA killer.sh Practice — Environment Recreation Kit

Since your killer.sh access expired, this recreates the *starting state*
for each of the 17 questions in your notes, so you can solve them fresh
against your own cluster. These are setup scripts/manifests only — no
solutions included (you already have the answer sheet).

## Fully simulatable (just apply/run)
| Q | Dir | How |
|---|-----|-----|
| 1 | q01-contexts | `./generate-kubeconfig.sh` |
| 2 | q02-cert-manager | `./setup.sh` |
| 3 | q03-statefulset | `kubectl apply -f setup.yaml` |
| 4 | q04-qos-classes | `kubectl apply -f setup.yaml` |
| 5 | q05-kustomize | `./setup.sh` |
| 6 | q06-pv-pvc | `kubectl apply -f setup.yaml` |
| 7 | q07-metrics | `./setup.sh` |
| 9 | q09-sa-api-access | `kubectl apply -f setup.yaml` |
| 10 | q10-rbac | `kubectl apply -f setup.yaml` |
| 11 | q11-daemonset | `kubectl apply -f setup.yaml` |
| 13 | q13-gateway-api | `./setup.sh` |
| 15 | q15-networkpolicy | `kubectl apply -f setup.yaml` |
| 16 | q16-coredns | no setup, see NOTES.md, start directly |

## Needs real infra you provide (manifests alone can't fake it — see NOTES.md)
| Q | Dir | Why |
|---|-----|-----|
| 8 | q08-kubeadm-join | needs a real 2nd node with an older kubeadm/kubelet not yet joined |
| 12 | q12-anti-affinity | needs exactly 2 schedulable worker nodes for the exact behaviour described |
| 14 | q14-cert-expiration | needs SSH/root on a real kubeadm control-plane node (PKI on disk) |
| 17 | q17-crictl | needs SSH/root on the node running the Pod (crictl access) |

## Quick start
```bash
for d in q03-statefulset q04-qos-classes q06-pv-pvc q09-sa-api-access \
         q10-rbac q11-daemonset q12-anti-affinity q15-networkpolicy \
         q17-crictl; do
  kubectl apply -f "$d/setup.yaml"
done
./q01-contexts/generate-kubeconfig.sh
./q02-cert-manager/setup.sh
./q05-kustomize/setup.sh
./q07-metrics/setup.sh
./q13-gateway-api/setup.sh
```

Clean up a namespace-based exercise with e.g. `kubectl delete ns project-h800`.
