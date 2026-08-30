# Q12 notes
The interesting part of this question (3rd replica stays Pending) only
shows up if your cluster has exactly 2 schedulable worker nodes (plus a
tainted control-plane, or a control-plane that's also excluded). On a
single-node cluster (e.g. one kind node, one minikube node) all 3 Pods
will just queue for the same node and 2 will stay Pending instead of 1 —
still illustrates the affinity/topology-spread mechanism, just with
different numbers. Adjust replicas or node count to match what you have.
