# Host

## Requirements

- [docker](https://docs.docker.com/get-docker/)
- [docker-compose](https://docs.docker.com/compose/install/)
- [aws cli](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- [kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl)
- [gcloud](https://cloud.google.com/sdk/docs/install)


## Setup

### Cluster

1. Sign into GCP:

```bash
gcloud auth login
```

2. Create a GCP project:

```bash
export PROJECT="ctf-$RANDOM"
gcloud projects create $PROJECT
gcloud config set project $PROJECT
```

__NOTE__: After you finish the CTF, you can delete the project, removing all resources associated with the project.

3. Make sure that billing is enabled for your Cloud project.
  - Learn how to [check if billing is enabled on a project](https://cloud.google.com/billing/docs/how-to/verify-billing-enabled).
  - Run this command to get a URL in your terminal to enable billing with: 

```bash
echo "https://console.cloud.google.com/billing/linkedaccount\?project\=$PROJECT"
```

4. Enable the GKE service API

```bash
gcloud services enable container.googleapis.com
```

__NOTE__: If you have an error regarding _billing_, please review the previous step

5. Create a GKE cluster:

```bash
export NAME="$(whoami)-$RANDOM"
gcloud container clusters create "${NAME}" \
  --labels "usage=dev,owner=$(whoami)" \
  --zone us-west2-a \
  --num-nodes 1
```

### Presentation Setup

1. Setup `/etc/hosts` file:

__NOTE__: Updating the `/etc/hosts` file allows you to use a URL on your machines browser to view GitLab and access the bucket.

```sh
sudo -- sh -c -e "echo '127.0.0.1 gitlab.foobar.com' >> /etc/hosts";
sudo -- sh -c -e "echo '127.0.0.1 bucket.foobar.com' >> /etc/hosts";
```

2. Unzip the GitLab data:

```sh
unzip gitlab.zip
```

3. Run `docker-compose up -d`

__NOTE__: When running this for the first time, it can take 10 minutes to get GitLab up and running
  - Wait for it to return healthy:

```sh
docker ps
```

### Application Setup

You currently have cluster-admin access to your cluster. This means we can setup the cluster for the CTF.

1. Run `./setup.sh`

## Checks

Use the following checks to give you confidence that everything is setup correctly to deliver your CTF!

### foobar.com

[ ] Check <gitlab.foobar.com> and <bucket.foobar.com> are added to `/etc/hosts`

- Open the `/etc/hosts` file with your preferred editor:

```sh
sudo nano /etc/hosts
```

- Amend `/etc/hosts/` accordingly:

```txt
127.0.0.1 gitlab.foobar.com
127.0.0.1 bucket.foobar.com
```

### kubeconfig

- [ ] Check config has been set

### musicbox reset

- [ ] Reset `boombox`

```sh
kubectl delete pods -A --selector app=musicbox
```
