# Lab 4 - Testing Kubernetes

- [Back to Threat Modelling Lab 4](/lab4/README.md)

> Contents for the Threat Modelling workshop delivered by [Control Plane](https://control-plane.io).

This is a local example of the Katacoda lab.

## Prerequisite

> The following demo is built for Linux (Tested on Debian)

- [Make](https://www.gnu.org/software/make/manual/make.html)
- [Docker](https://www.docker.com)
- [KinD](https://kind.sigs.k8s.io/docs/user/quick-start/)

## Demo

### Demo 1 - Run privileged pod with test

```bash
make create
kubectl apply -f source/nginx.yaml
make bats-detik
```

### Demo 2 - Enable psp and fail to run privileged pod with test

```bash
make psp-enable
sleep 60
kubectl apply -f source/psp-restrictive.yaml
kubectl apply -f source/nginx.yaml
make bats-detik
```

### Teardown

```bash
make delete
```

## References

- [KinD](https://kind.sigs.k8s.io/)
  - [KinD Installation](https://kind.sigs.k8s.io/docs/user/quick-start/#installation)
  - [Docker image registry - Kindest](https://hub.docker.com/u/kindest)
- [bats-detik](https://github.com/bats-core/bats-detik)