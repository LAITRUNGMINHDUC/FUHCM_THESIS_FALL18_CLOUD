AZURE_GROUPNAME='THESIS-AKS' # Resource Group that Kubernetes Cluster inside
AZURE_KUBE_CLUSTER_NAME='DUCPHUONGKHANG-KUBE' # Name of Kubernetes Cluster
AZURE_STORAGE_ACCOUNT='ducphuongkhang' # Name of Storage Account in lowercase

NODE_RESOURCE_GROUP=$(az aks show --resource-group $AZURE_GROUPNAME --name $AZURE_KUBE_CLUSTER_NAME --query nodeResourceGroup -o tsv)

az storage account create --resource-group $NODE_RESOURCE_GROUP  --name $AZURE_STORAGE_ACCOUNT --sku Standard_LRS

kubectl apply -f azure-files-storage.yaml

kubectl apply -f azure-kube-persistent-volumes.yaml 