#!/bin/bash

# Create Azure Active Directory - App Registration
APPID='12e03b34-3406-463d-b9f2-850671946c15'
APPSECRET='Y0|{+|>RC#&6]^){)}:%(@[;to^@R{!i.a=.>2$!I?'

AZURE_GROUPNAME='THESIS-AKS'
AZURE_KUBE_CLUSTER_NAME='DUCPHUONGKHANG-KUBE'
AZURE_KUBE_NODE='1'
AZURE_KUBE_NODE_SIZE='Standard_B2s' #https://azure.microsoft.com/en-us/blog/introducing-burstable-vm-support-in-aks/

# Create RESOURCE GROUP
az group create --name $AZURE_GROUPNAME --location southeastasia 

# Create AKS Cluster
az aks create --resource-group $AZURE_GROUPNAME \
	--name $AZURE_KUBE_CLUSTER_NAME \
	--node-count $AZURE_KUBE_NODE \
	--node-vm-size $AZURE_KUBE_NODE_SIZE \
	--enable-addons monitoring \
	--service-principal $APPID \
	--client-secret $APPSECRET \
	--generate-ssh-keys

# Get AKS Credential
az aks get-credentials --resource-group $AZURE_GROUPNAME --name $AZURE_KUBE_CLUSTER_NAME

# Create RBAC role for Dashboard
kubectl create clusterrolebinding kubernetes-dashboard -n kube-system --clusterrole=cluster-admin --serviceaccount=kube-system:kubernetes-dashboard