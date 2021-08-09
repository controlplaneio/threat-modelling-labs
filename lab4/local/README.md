# Lab 4 - Testing Kubernetes

> Contents for the Threat Modelling workshop delivered by [Control Plane](https://control-plane.io) 

## Setup

### Install

```bash
make install
```

### KinD

```bash
kind create cluster --config kind-cluster-build.yaml
kind get clusters
kind get nodes --name threat-modelling
kind get kubeconfig --name threat-modelling > threat-modelling-config.yaml
```

## Demo

### Demo 1 - run privileged pod with test

```bash
make create
kubectl apply -f source/nginx.yaml
make bats-detik
```

### Demo 2 - Enable psp and fail to run privileged pod with test

```bash
make psp-enable
kubectl apply -f psp-r.yaml
kubectl apply -f nginx-priv.yaml
make bats-detik
```

## References

- [KinD](https://kind.sigs.k8s.io/)
  - [KinD Installation](https://kind.sigs.k8s.io/docs/user/quick-start/#installation)
  - [Docker image registry - Kindest](https://hub.docker.com/u/kindest)
- [bats-detik](https://github.com/bats-core/bats-detik)