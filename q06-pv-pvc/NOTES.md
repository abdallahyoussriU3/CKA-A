# Q6 notes
hostPath /Volumes/Data needs to actually exist on whichever node the Pod
lands on (or the container will just see an empty/created dir — fine for
practice). If your cluster has multiple nodes, pin the Pod with nodeName
or a nodeSelector so the hostPath is predictable, or just accept it may
land anywhere.
