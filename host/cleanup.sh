#! /bin/bash

kubectl delete pods -A --selector app=boombox
kubectl delete pod -n the-homer homer-pod-priv
