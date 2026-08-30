# Q8 — cannot be simulated with manifests

This question needs an actual second machine/VM with kubelet+kubeadm
installed at an OLDER version than the control plane, not yet joined to
the cluster. That's cluster topology, not something a manifest can fake.

To rebuild this exercise on your own infra you need:
1. A control-plane node running kubeadm cluster at some version (e.g. 1.35.6).
2. A second VM with an older kubeadm/kubelet/kubectl installed
   (e.g. 1.34.8) via apt, NOT yet joined (no kubeadm join run on it yet).

If you want a cheap way to get a real multi-node kubeadm lab, options are:
- Multipass / Vagrant with 2+ Ubuntu VMs
- kubeadm on bare EC2/GCE instances
- kind does NOT support real kubeadm upgrade/join workflows (single binary,
  no separate kubelet packages) — not suitable for this specific question.

Once you have that, the actual task steps are exactly as documented in your
original answer sheet (apt-cache show, apt-get install pinned version,
kubeadm token create --print-join-command, kubeadm join).
