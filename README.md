# KubeCon NA 2022 - Hack Back; Let’s Learn Security With CTFs!

This repository contains the example CTF challenges for the "Hack Back; Let’s Learn Security With CTFs!"
talk presented at KubeCon NA 2022 in Detroit.

## Challenge 1 - Aut0m0tiv3 

TODO: storyline around a "car" container which is too secure. Try to repair it, modify some parameters and drive around
Detroit to find the flag.

Connect to GKE cluster:
```bash
gcloud container clusters get-credentials kubecon-na-ctf-1 --zone europe-central2-a --project natalia-testing-288908
```

Example "car" pod spec:
```bash
apiVersion: v1
kind: Pod
metadata:
  name: car-the-pod
spec:
  containers:
  - name: car-the-pod
    image: nginx:latest
    ports:
    - containerPort: 80
```
