helm install postgres-database oci://registry-1.docker.io/bitnamicharts/postgresql -n my-release-uros-namespace  --set global.postgresql.auth.postgresPassword=password,global.postgresql.auth.database=socialweb

