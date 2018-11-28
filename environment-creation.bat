echo off
echo Creating Azure Kubernetes Cluster (AKS) in Azure.
set resourceGroupName=default
set /p resourceGroupName=Please enter resource group name (default name: %resourceGroupName%-rg).

set nodeCount=1
set region=eastus
set "acrName=%resourceGroupName%acr"
set "clusterName=%resourceGroupName%-cluster"
set "resourceGroupName=%resourceGroupName%-rg"
echo %resourceGroupName% %clusterName%

echo creating resource group with name: (%resourceGroupName%) in region %region%
call az group create --name %resourceGroupName% --location %region%

echo creating ACR
call az acr create --resource-group %resourceGroupName% --name %acrName% --sku Basic

echo Loging in to ACR
call az acr login --name %acrName%

echo Enabled admin access for cluster (%clusterName%)
call az acr update -n %acrName% --admin-enabled true

echo creating AKS - cluster (%clusterName%) with nodes (%nodeCount%)
call az aks create --resource-group %resourceGroupName% --name %clusterName% --node-count %nodeCount% --generate-ssh-keys

echo Getting AKS (%clusterName%) - cluster credentials - with resource group (%resourceGroupName%).
call az aks get-credentials --resource-group %resourceGroupName% --name %clusterName%

echo Configuring kubectl cluster
call kubectl create clusterrolebinding kubernetes-dashboard -n kube-system --clusterrole=cluster-admin --serviceaccount=kube-system:kubernetes-dashboard

call kubectl get node

pause;