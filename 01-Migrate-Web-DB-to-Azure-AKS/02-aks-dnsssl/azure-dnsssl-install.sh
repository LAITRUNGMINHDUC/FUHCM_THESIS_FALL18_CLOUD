#!/bin/bash

helm install stable/cert-manager \
    --namespace kube-system \
    --set ingressShim.defaultIssuerName=letsencrypt-prod \
    --set ingressShim.defaultIssuerKind=ClusterIssuer

# Public IP address of your ingress controller
IP="104.215.199.249" 

# Name to associate with public IP address
DNSNAME="ducphuongkhang-ingress"

# Get the resource-id of the public ip
PUBLICIPID=$(az network public-ip list --query "[?ipAddress!=null]|[?contains(ipAddress, '$IP')].[id]" --output tsv)

# Update public ip address with DNS name
az network public-ip update --ids $PUBLICIPID --dns-name $DNSNAME

#
kubectl apply -f azure-dnsssl-issuer.yaml

kubectl apply -f azure-dnsssl-certificate.yaml