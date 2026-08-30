# Q17 notes
Only the Pod creation is a manifest concern (setup.yaml gives you the
namespace). The crictl part requires SSH/root access to whichever
containerd-backed node the Pod actually lands on. If your cluster is
managed (EKS/GKE/AKS) you likely won't have that node access at all —
this question is really only practicable on a self-managed
kubeadm/kind/k3s style cluster where you can SSH or `docker exec` into
the node.
