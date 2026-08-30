# Q16 notes
No pre-setup needed — this works against whatever CoreDNS ConfigMap your
cluster already has (kubeadm installs one by default in kube-system named
"coredns"; managed clusters may differ slightly in the Corefile format,
but the exercise — back it up, add `custom-domain` alongside
`cluster.local`, restart, verify with nslookup from a busybox pod — works
the same). Just start directly:
  kubectl -n kube-system get cm coredns -oyaml > coredns_backup.yaml
