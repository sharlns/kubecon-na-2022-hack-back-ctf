# Host

## Requirements

- [docker](https://docs.docker.com/get-docker/)
- [docker-compose](https://docs.docker.com/compose/install/)
- [aws cli](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- [kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl)

## Setup

### Cluster Setup

- TODO

### Presentation Setup

- Run `docker-compose up -d`

### Application Setup

- TODO: create dynamic variable for cluster name in `setup.sh`
- Run `./setup.sh`

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

[ ] Check config has been set

### musicbox reset

- [ ] Reset `boombox`

```sh
kubectl delete pods -A --selector app=musicbox
```
