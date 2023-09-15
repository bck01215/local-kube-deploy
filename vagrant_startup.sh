#!/bin/bash

echo "192.168.56.56 server1" >> /etc/hosts
echo "192.168.56.34 server2" >> /etc/hosts
echo "192.168.56.35 server3" >> /etc/hosts
echo "192.168.56.36 client1" >> /etc/hosts
echo "192.168.56.37 client2" >> /etc/hosts
echo "192.168.56.38 client3" >> /etc/hosts
firewall-cmd --add-port=8080/tcp
firewall-cmd --add-port=8081/tcp
firewall-cmd --add-port=8080/tcp --permanent
firewall-cmd --add-port=8081/tcp --permanent


# Get the hostname
hostname=$(hostname)

# Check if the hostname contains "serv"
if [[ $hostname == *serv* ]]; then
    parted -s "/dev/sdb" mklabel gpt
    parted -s "/dev/sdb" mkpart priamry 0% 100%
    mkdir -p /mnt/minio
    mkfs.xfs /dev/sdb1
    echo "/dev/sdb1 /mnt/minio                       xfs     defaults        0 0" >> /etc/fstab
    mount -a
else
    echo "Hostname does not contain 'serv'."
fi