NAME="ducphuongkhang-ingress"

kubectl apply -f azure-helm-rbac.yaml #https://docs.microsoft.com/en-us/azure/aks/kubernetes-helm
kubectl create clusterrolebinding add-on-cluster-admin --clusterrole=cluster-admin --serviceaccount=kube-system:default
helm init --service-account tiller

helm install stable/nginx-ingress \
	--name $NAME \
	--namespace kube-system \
	--set controller.replicaCount=2 \
	--set rbac.create=true

# Source IP for Ingress instance
kubectl patch svc $NAME-nginx-ingress-controller  -p '{"spec":{"externalTrafficPolicy":"Local"}}' -n kube-system