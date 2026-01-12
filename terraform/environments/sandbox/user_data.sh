#!/bin/bash
set -e

# Update and Install Dependencies
apt-get update
apt-get install -y docker.io openjdk-17-jdk curl unzip

# Start Docker
systemctl enable docker
systemctl start docker
usermod -aG docker ubuntu

# Install K3s (Lightweight Kubernetes)
curl -sfL https://get.k3s.io | sh -
# Allow 'ubuntu' user to use kubectl
mkdir -p /home/ubuntu/.kube
cp /etc/rancher/k3s/k3s.yaml /home/ubuntu/.kube/config
chown ubuntu:ubuntu /home/ubuntu/.kube/config
chmod 600 /home/ubuntu/.kube/config
echo "export KUBECONFIG=/home/ubuntu/.kube/config" >> /home/ubuntu/.bashrc

# Output status
echo "DevOps Sandbox Initialization - Complete"
