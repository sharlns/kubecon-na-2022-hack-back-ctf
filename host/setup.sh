#! /bin/bash

# Setup the-homer

kubectl apply -f ./k8s/the-homer.yaml

# Setup beep-beep

kubectl apply -f ./k8s/beep-beep.yaml

# Setup boombox

kubectl apply -f ./k8s/boombox.yaml

# Create a new SA and create a config file

clusterName=$NAME
namespace=the-homer
serviceAccount=the-homer-sa
newfile=config

server=$(kubectl config view --minify --raw -o jsonpath='{.clusters[].cluster.server}')
secretName=$(kubectl --namespace $namespace get serviceAccount $serviceAccount -o jsonpath='{.secrets[0].name}')
ca=$(kubectl --namespace $namespace get secret/$secretName -o jsonpath='{.data.ca\.crt}')
token=$(kubectl --namespace $namespace get secret/$secretName -o jsonpath='{.data.token}' | base64 --decode)

echo "
---
apiVersion: v1
kind: Config
clusters:
  - name: ${clusterName}
    cluster:
      certificate-authority-data: ${ca}
      server: ${server}
contexts:
  - name: ${serviceAccount}@${clusterName}
    context:
      cluster: ${clusterName}
      namespace: ${namespace}
      user: ${serviceAccount}
users:
  - name: ${serviceAccount}
    user:
      token: ${token}
current-context: ${serviceAccount}@${clusterName}
" >> ${newfile}

# Configure S3 bucket

aws configure set aws_access_key_id "uUcDGYowgomWC8Z5"
aws configure set aws_secret_access_key "FLAG(IckyThumb)"
aws configure set default.region "us-east-1"
aws configure set default.output "json"

# Copy config file to S3 bucket

aws --endpoint-url=http://localhost:4566 s3 mb s3://foobar-creds
aws --endpoint-url=http://localhost:4566 s3 cp config s3://foobar-creds
aws --endpoint-url=http://localhost:4566 s3 ls s3://foobar-creds
