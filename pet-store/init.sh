echo "Creating namespace"
kubectl create ns pet-store

echo "Installing postgres database"
helm install postgres-database oci://registry-1.docker.io/bitnamicharts/postgresql -n pet-store  --set global.postgresql.auth.postgresPassword=password,global.postgresql.auth.database=postgres

echo "Running helm chart"
helm install social-web . -n pet-store