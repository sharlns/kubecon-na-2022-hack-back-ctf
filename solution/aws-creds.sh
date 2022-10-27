#! /bin/bash

# Configure S3 bucket

aws configure set aws_access_key_id "uUcDGYowgomWC8Z5"
aws configure set aws_secret_access_key "FLAG(IckyThumb)"
aws configure set default.region "us-east-1"
aws configure set default.output "json"

# Copy config file from S3 bucket

aws --endpoint-url=http://localhost:4566 s3 cp s3://foobar-creds/config .

