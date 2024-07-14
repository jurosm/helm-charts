echo "Creating kind cluster"
kind create cluster --config ./kind.yaml

echo "Installing ingress"
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml

sleep 20s 

kubectl wait --namespace ingress-nginx --for=condition=ready pod --selector=app.kubernetes.io/component=controller --timeout=120s

echo "Creating namespace"
kubectl create ns social-web-dev

echo "Installing postgres database"
helm install postgres-database oci://registry-1.docker.io/bitnamicharts/postgresql -n social-web-dev  --set global.postgresql.auth.postgresPassword=password,global.postgresql.auth.database=socialweb

echo "Running helm chart"
helm install social-web . -n social-web-dev