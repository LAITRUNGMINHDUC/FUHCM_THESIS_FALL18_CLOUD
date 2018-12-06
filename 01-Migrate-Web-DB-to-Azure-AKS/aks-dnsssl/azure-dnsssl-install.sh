#!/bin/bash
NAME='letsencrypt-ssl'
INGRESS_DNS_NAMESPACE='dpk-ingress-dns'

# Public IP address of your ingress controller
IP="104.215.181.249" 
# Name of Ingress in azure-install-aks-ingress.sh
DNSNAME="ducphuongkhang-ingress"

helm install stable/cert-manager \
    --namespace $INGRESS_DNS_NAMESPACE \
    --name $NAME \
    --set ingressShim.defaultIssuerName=letsencrypt-prod \
    --set ingressShim.defaultIssuerKind=ClusterIssuer    

# Get the resource-id of the public ip
PUBLICIPID=$(az network public-ip list --query "[?ipAddress!=null]|[?contains(ipAddress, '$IP')].[id]" --output tsv)

# Update public ip address with DNS name
az network public-ip update --ids $PUBLICIPID --dns-name $DNSNAME

kubectl apply -f azure-dnsssl-issuer.yaml

kubectl apply -f azure-dnsssl-certificate.yaml