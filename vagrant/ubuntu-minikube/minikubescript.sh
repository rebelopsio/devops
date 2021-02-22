#!/bin/bash
#Install minikube
echo "Downloading Minikube"
curl -q -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 2>/dev/null
chmod +x minikube
sudo mv minikube /usr/local/bin/
#Install kubectl
echo "Downloading Kubectl"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" 2>/dev/null
chmod +x kubectl
sudo mv kubectl /usr/local/bin/
# Install crictl
curl -qL https://github.com/kubernetes-sigs/cri-tools/releases/download/v1.16.1/crictl-v1.16.1-linux-amd64.tar.gz 2>/dev/null | tar xzvf -
chmod +x crictl
sudo mv crictl /usr/local/bin/
#Install stern
# TODO: Check sha256sum
echo "Downloading Stern"
curl -q -Lo stern https://github.com/wercker/stern/releases/download/1.10.0/stern_linux_amd64 2>/dev/null
chmod +x stern
sudo mv stern /usr/local/bin/
#Install kubecfg
# TODO: Check sha256sum
echo "Downloading Kubecfg"
curl -q -Lo kubecfg https://github.com/ksonnet/kubecfg/releases/download/v0.9.0/kubecfg-linux-amd64 2>/dev/null
chmod +x kubecfg
sudo mv kubecfg /usr/local/bin/
#Setup minikube
echo "127.0.0.1 minikube minikube." | sudo tee -a /etc/hosts
mkdir -p $HOME/.minikube
mkdir -p $HOME/.kube
touch $HOME/.kube/config
export KUBECONFIG=$HOME/.kube/config
# Permissions
sudo chown -R $USER:$USER $HOME/.kube
sudo chown -R $USER:$USER $HOME/.minikube
export MINIKUBE_WANTUPDATENOTIFICATION=false
export MINIKUBE_WANTREPORTERRORPROMPT=false
export MINIKUBE_HOME=$HOME
export CHANGE_MINIKUBE_NONE_USER=true
export KUBECONFIG=$HOME/.kube/config
# Disable SWAP since is not supported on a kubernetes cluster
sudo swapoff -a
## Start minikube
sudo -E minikube start -v 4 --driver=none --kubernetes-version $(curl -L -s https://dl.k8s.io/release/stable.txt) --bootstrapper kubeadm
## Addons
sudo -E minikube addons  enable ingress
## Configure vagrant clients dir
printf "export MINIKUBE_WANTUPDATENOTIFICATION=false\n" >> /home/vagrant/.bashrc
printf "export MINIKUBE_WANTREPORTERRORPROMPT=false\n" >> /home/vagrant/.bashrc
printf "export MINIKUBE_HOME=/home/vagrant\n" >> /home/vagrant/.bashrc
printf "export CHANGE_MINIKUBE_NONE_USER=true\n" >> /home/vagrant/.bashrc
printf "export KUBECONFIG=/home/vagrant/.kube/config\n" >> /home/vagrant/.bashrc
printf "source <(kubectl completion bash)\n" >> /home/vagrant/.bashrc
# Permissions
sudo chown -R $USER:$USER $HOME/.kube
sudo chown -R $USER:$USER $HOME/.minikube
# Enforce sysctl
sudo sysctl -w vm.max_map_count=262144
sudo echo "vm.max_map_count=262144" | sudo tee -a /etc/sysctl.d/90-vm_max_map_count.conf