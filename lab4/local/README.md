# Lab 4 - Testing Kubernetes (Local)

- [Back to Threat Modelling Lab 4](/lab4/README.md)

> Contents for the Threat Modelling workshop delivered by [Control Plane](https://control-plane.io).

This lab can be run locally using the following inscructions. 

## Prerequisite

> The following demo is built for Linux (Tested on Debian)

- [Make](https://www.gnu.org/software/make/manual/make.html)
- [Docker](https://www.docker.com)
- [KinD](https://kind.sigs.k8s.io/docs/user/quick-start/)

## Demo

### Demo 1 - Run privileged pod with test

Create a kind cluster and run a test which passes if a privileged pod cannot be deployed on the cluster. 

```bash
make create
make bats-detik
```

Observe that the test fails, as it is possible to deploy the privileged pod. 

### Demo 2 - Install Gatekeeper and enforce admission control policy

Deploy Gatekeeper to the cluster, and create a Gatekeeper Constraint and Constraint Template to prevent privileged pods from being admitted to the cluster. 

```bash
make install-gatekeeper
sleep 60
make deploy-constraint
```

Run the test again:
```bash
make bats-detik
```

Observe that the test now passes. 

### Teardown

```bash
make delete
```

## References

- [KinD](https://kind.sigs.k8s.io/)
  - [KinD Installation](https://kind.sigs.k8s.io/docs/user/quick-start/#installation)
  - [Docker image registry - Kindest](https://hub.docker.com/u/kindest)
- [bats-detik](https://github.com/bats-core/bats-detik)
- [Gatekeeper](https://github.com/open-policy-agent/gatekeeper)