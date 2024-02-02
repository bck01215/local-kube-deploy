#!/bin/bash

echo "192.168.57.33 server1" >> /etc/hosts
echo "192.168.57.34 server2" >> /etc/hosts
echo "192.168.57.35 server3" >> /etc/hosts

yum update -y
yum upgrade -y
firewall-cmd --permanent --add-port=6443/tcp #apiserver
firewall-cmd --permanent --add-port=2379/tcp --add-port=2380/tcp #etcd
firewall-cmd --permanent --add-port=10250/tcp #kubelet
firewall-cmd --permanent --zone=trusted --add-source=10.101.0.0/16 \
    --add-source=192.168.57.35 --add-source=192.168.57.34 --add-source=192.168.57.33
firewall-cmd --reload
curl -sfL https://get.k3s.io | sh -s - server --cluster-cidr=10.101.0.0/17 --service-cidr=10.101.128.0/17 --cluster-dns=10.101.128.10 \
    --server https://192.168.57.33:6443 --flannel-backend none --token RANDOM_TOKEN
