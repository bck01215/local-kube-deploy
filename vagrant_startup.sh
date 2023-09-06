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
