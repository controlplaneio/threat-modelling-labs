# threat-modelling-labs

## Initial commit notes

- bats-detik folder cloned from: https://github.com/bats-core/bats-detik
- idea is to create a kind cluster, share kubeconfig file with the detik container and run a bats test to check that a privileged nginx pod cannot be deployed to the cluster 
- two PSPs in place - restrictive and permissive (psp-p.yaml, psp-r.yaml), with cluster roles and bindings for privileged service accounts, e.g. kube-proxy
- initial test placeholder in priv-test.bats

## Setup

- Instal KinD

```bash
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.11.1/kind-linux-amd64
chmod +x ./kind
mv ./kind /some-dir-in-your-PATH/kind
```

### KinD

```bash
kind create cluster --config kind-cluster-build.yaml
kind get clusters
kind get nodes --name threat-modelling
kind get kubeconfig --name threat-modelling > threat-modelling-config.yaml
```

### Demo

```bash
kubectl apply -f nginx-priv.yaml
kubectl get pods
kubectl delete pods --all

```

## Lab

- Run KinD Cluster
- Deny all PSP
- Apply PSP
- Run nginx container

## References

- [KinD](https://kind.sigs.k8s.io/)
  - [KinD Installation](https://kind.sigs.k8s.io/docs/user/quick-start/#installation)
  - [Docker image registry - Kindest](https://hub.docker.com/u/kindest)