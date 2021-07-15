# Threat Modelling Labs

> Contents for the Threat Modelling workshop delivered by [Control Plane](https://control-plane.io) 

## Notes

- bats-detik folder cloned from: https://github.com/bats-core/bats-detik
- idea is to create a kind cluster, share kubeconfig file with the detik container and run a bats test to check that a privileged nginx pod cannot be deployed to the cluster 
- two PSPs in place - restrictive and permissive (psp-p.yaml, psp-r.yaml), with cluster roles and bindings for privileged service accounts, e.g. kube-proxy
- initial test placeholder in priv-test.bats

## Install

## Setup

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

### Demo 1 - run privileged pod with test

```bash
make create
kubectl apply -f nginx-priv.yaml
make bats-detik
kubectl delete pods --all
```

### Demo 2 - Enable psp and fail to run privileged pod with test

```bash
make psp-enable
kubectl apply -f psp-r.yaml
kubectl apply -f nginx-priv.yaml
make bats-detik
```

## Lab

- Run KinD Cluster
- Deny all PSP
- Apply PSP
- Run nginx container

```bash
docker run -it -v ${PWD}/sources:/home/testing/sources -v ${PWD}/config:/home/testing/.kube/config --network="host" denhamparry/bats-detik:0.0.1 bats /home/testing/sources/psp-privileged-test.bats
```

## References

- [KinD](https://kind.sigs.k8s.io/)
  - [KinD Installation](https://kind.sigs.k8s.io/docs/user/quick-start/#installation)
  - [Docker image registry - Kindest](https://hub.docker.com/u/kindest)
- [bats-detik](https://github.com/bats-core/bats-detik)