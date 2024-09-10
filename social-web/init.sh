echo "Creating kind cluster"
kind create cluster --config ./kind.yaml

helm repo add jetstack https://charts.jetstack.io  
helm repo add bitnami https://charts.bitnami.com/bitnami 
helm repo add metrics-server https://kubernetes-sigs.github.io/metrics-server
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm install cert-manager jetstack/cert-manager -n social-web --version v1.14.4 --set installCRDs=true

echo "Installing ingress"
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml

sleep 20s 

kubectl wait --namespace ingress-nginx --for=condition=ready pod --selector=app.kubernetes.io/component=controller --timeout=120s

helm install prometheus prometheus-community/prometheus 

echo "Creating namespace"
kubectl create ns social-web-dev

echo "Running helm chart"
helm install social-web . -n social-web-dev