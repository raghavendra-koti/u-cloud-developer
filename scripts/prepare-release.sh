#!/usr/bin/bash
curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.14.0/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
sudo mkdir ~/.kube

curl -o aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.14.6/2019-08-22/bin/linux/amd64/aws-iam-authenticator
chmod +x ./aws-iam-authenticator
sudo mv ./aws-iam-authenticator /usr/local/bin/aws-iam-authenticator
  
sudo mv kubeconfig $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/
  
kubectl config set clusters.my-dev-cluster.ap-south-1.eksctl.io.certificate-authority-data $KUBE_CERTIFICATE
kubectl config set clusters.my-dev-cluster.ap-south-1.eksctl.io.server $KUBE_SERVER

kubectl apply -f course-03/exercises/udacity-c3-deployment/k8s/aws-secret.yaml
kubectl apply -f course-03/exercises/udacity-c3-deployment/k8s/env-secret.yaml
kubectl apply -f course-03/exercises/udacity-c3-deployment/k8s/env-configmap.yaml
