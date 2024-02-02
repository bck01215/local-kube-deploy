#!/bin/bash

echo "192.168.57.33 server1" >> /etc/hosts
echo "192.168.57.34 server2" >> /etc/hosts
echo "192.168.57.35 server3" >> /etc/hosts

yum update -y
yum upgrade -y
firewall-cmd --permanent --add-port=6443/tcp #apiserver
firewall-cmd --permanent --add-port=2379/tcp --add-port=2380/tcp #etcd
firewall-cmd --permanent --add-port=10250/tcp #kubelet
#pods and servers
firewall-cmd --permanent --zone=trusted --add-source=10.101.0.0/16 \
    --add-source=192.168.57.35 --add-source=192.168.57.34 --add-source=192.168.57.33
firewall-cmd --reload
curl -sfL https://get.k3s.io | sh -s - --cluster-cidr=10.101.0.0/17 --service-cidr=10.101.128.0/17 --cluster-dns=10.101.128.10 \
    --cluster-init --flannel-backend none --token RANDOM_TOKEN --node-ip=192.168.57.33 --write-kubeconfig /root/.kube/config

sleep 20
export PATH=$PATH:/usr/local/bin/

mount bpffs -t bpf /sys/fs/bpf

wget https://github.com/cilium/cilium-cli/releases/download/v0.15.0/cilium-linux-amd64.tar.gz
tar -xzvf cilium-linux-amd64.tar.gz
mv cilium /usr/bin/
cilium install --version 1.15.0
kubectl get pods --all-namespaces -o custom-columns=NAMESPACE:.metadata.namespace,NAME:.metadata.name,HOSTNETWORK:.spec.hostNetwork --no-headers=true | grep '<none>' | awk '{print "-n "$1" "$2}' | xargs -L 1 -r kubectl delete pod
