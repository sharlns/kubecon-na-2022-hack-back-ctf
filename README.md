# KubeCon NA 2022 - Hack Back; Let’s Learn Security With CTFs

This repository contains the example CTF challenges for the "Hack Back; Let’s Learn Security With CTFs!"
talk presented at KubeCon NA 2022 in Detroit.

## Presenters

Thanks to [DALL·E](https://openai.com/blog/dall-e/)

### Natalia

![Natalia](natalia.png)

> An impressionists painting of someone surfing in Portugal

### Lewis

![Lewis](lewis.png)

> An imposter who is an engineer that looks tired but is ultimately happy with their family

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

- [Foobar Taxi Setup](https://github.com/denhamparry/foobar-taxi-setup)
- [BeepBeep](https://github.com/denhamparry/beepbeep)
- [Boombox](https://github.com/denhamparry/boombox)
