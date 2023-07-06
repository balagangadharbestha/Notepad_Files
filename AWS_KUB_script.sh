#!/bin/bash

# Update system packages
sudo apt update
sudo apt upgrade -y

# Disable swap
sudo swapoff -a
sudo sed -i '/ swap / s/^/#/' /etc/fstab

# Install Docker
sudo apt-get install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker

# Add Kubernetes repository and install K8s components
sudo apt-get update && sudo apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

# Initialize Kubernetes cluster
sudo kubeadm init

# Set up Kubernetes configuration for the user
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Install network add-on (Calico in this example)
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml

# Optional: Join worker nodes (if applicable)
# Replace `<worker-join-command>` with the actual join command from `kubeadm init` output
# Example: sudo kubeadm join <master-ip>:<master-port> --token <token> --discovery-token-ca-cert-hash <hash>
# Uncomment the following line and replace with the join command
# <worker-join-command>

