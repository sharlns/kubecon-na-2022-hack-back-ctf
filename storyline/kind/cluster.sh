#! /bin/sh

cat <<EOF | kind create cluster --name ctf --config=-
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
  kubeadmConfigPatches:
  - |
    kind: InitConfiguration
    nodeRegistration:
      kubeletExtraArgs:
        node-labels: "ingress-ready=true"
  extraPortMappings:
  - containerPort: 80
    hostPort: 8080
    protocol: TCP
  - containerPort: 443
    hostPort: 8443
    protocol: TCP
- role: worker
  extraMounts:
      - hostPath: $HOME/ctf/worker1
        containerPath: /mnt/disk1/data
  labels:
    minio: true
- role: worker
  extraMounts:
      - hostPath: $HOME/ctf/worker2
        containerPath: /mnt/disk1/data
  labels:
    minio: true
- role: worker
  extraMounts:
      - hostPath: $HOME/ctf/worker3
        containerPath: /mnt/disk1/data
  labels:
    minio: true
EOF


kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/provider/kind/deploy.yaml

