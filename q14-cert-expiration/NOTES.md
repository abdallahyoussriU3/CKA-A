# Q14 — needs a real kubeadm cluster

This one only makes sense on a cluster you control at the OS/kubeadm
level (kubeadm certs check-expiration, /etc/kubernetes/pki/apiserver.crt
on disk). Managed clusters (EKS/GKE/AKS) and kind don't expose this.

If you have SSH/root access to a kubeadm control-plane node, no setup is
needed — the certs already exist at /etc/kubernetes/pki/. Just practice
directly:
  openssl x509 -noout -text -in /etc/kubernetes/pki/apiserver.crt | grep Validity -A2
  kubeadm certs check-expiration | grep apiserver
