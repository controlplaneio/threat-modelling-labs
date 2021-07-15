# threat-modelling-labs

## Initial commit notes

- bats-detik folder cloned from: https://github.com/bats-core/bats-detik
- idea is to create a kind cluster, share kubeconfig file with the detik container and run a bats test to check that a privileged nginx pod cannot be deployed to the cluster 
- two PSPs in place - restrictive and permissive (psp-p.yaml, psp-r.yaml), with cluster roles and bindings for privileged service accounts, e.g. kube-proxy
- initial test placeholder in priv-test.bats