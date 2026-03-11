# Lab 4 - Testing Kubernetes (Local)

- [Back to Threat Modelling Lab 4](/lab4/README.md)

> Contents for the Threat Modelling workshop delivered by [Control Plane](https://control-plane.io).

This lab can be run locally using the following instructions.

## Prerequisite

> The following demo is built for Linux. You will need the following tools:

- [Make](https://www.gnu.org/software/make/manual/make.html)
- [Docker](https://www.docker.com)
- [kind](https://kind.sigs.k8s.io/docs/user/quick-start/)

## Demo

### Introduction and Setup

If you have not yet installed kind, you can do so by running

```bash
make install-kind
```

Once it is installed, create a kind cluster which we will use for this lab:  

```bash
make create
```

In this exercise, we will be enforcing admission control policies for resources we wish to deploy to our cluster. [Pod Security Standards](https://kubernetes.io/docs/concepts/security/pod-security-standards/) provide a great way to enforce pod hardening best practices quickly and easily. However, note that we did not configure the Kubernetes API server with a suitable admission configuration at cluster creation (as per [documentation here](https://kubernetes.io/docs/tutorials/security/cluster-level-pss/)):

```bash
cat kind/threat-modelling.yaml
```

As an instructive task in defining and testing controls derived from our threat model, we are instead going to demonstrate how [Kyverno](https://kyverno.io/) can be used to go beyond Pod Security Standards (PSS) and define custom policies. Kyverno is a policy engine designed specifically for Kubernetes, with policies written as native Kubernetes YAML declarations. This makes them highly accessible for Kubernetes administrators. It should be noted that in accordance with the Module 3 Lab, the choice between different implementation methods for a control ultimately comes down to an effort vs benefit decision, and for many use cases, simply using Baseline or Restricted Pod Security Standards will be the most efficient way to protect against our biggest threats. However, if your threat profile is deemed to be sufficient to require more intricate controls, the overhead of maintaining custom policies may be seen as worthwhile.

In this lab, we will first use Kyverno to prevent privileged pods from running. Note that the privileged flag is only one dangerous configuration that is prevented by the Baseline PSS, and in practice we would want to enforce a more complete policy. However, for the purposes of demonstrating how we can test the effectiveness of controls, this example will suffice. To demonstrate how we can develop custom controls and test their effectiveness, we will then develop a second Kyverno policy to only permit images to be pulled from an approved repository. This mimics a control where production images are scanned, and promoted to a specific internal artefact repository provided they conform to organisational policies, and any vulnerabilities have been appropriately triaged in accordance with agreed procedures.

### Demo 1a - Testing Privileged Pods

In order to test the effectiveness of our policies, we will use [bats-detik](https://github.com/bats-core/bats-detik). Observe the test that we can run to check whether privileged pods can run in our cluster:

```bash
cat source/control-tests/privileged/privileged-test.bats
```

We can now run this test as follows:

```bash
make privileged-test
```

Observe that one test fails, as it is possible to deploy the privileged pod.

### Demo 1b - Install Kyverno and enforce validating admission control policy

Deploy Kyverno to the cluster:

```bash
make install-kyverno
```

Observe the YAML that we will use to generate our first policy:

```bash
cat source/policy/privileged/kyverno-policy.yaml
```

Notice that the resource kind we are creating is a `ClusterPolicy`. In Kyverno, a `ClusterPolicy` applies globally across the entire Kubernetes cluster, regardless of namespace. We use it in this lab because fundamental security controls like blocking privileged containers or restricting image registries should generally be applied comprehensively. If a threat actor finds even one unprotected namespace, they might use it to escalate privileges and compromise the entire cluster.

Conversely, Kyverno also offers a namespaced `Policy` kind. You would use a namespaced `Policy` instead of a `ClusterPolicy` when:

- Multi-tenant clusters: Different teams or applications share a cluster but have vastly different security or operational requirements.
- Delegation: You want to empower namespace administrators to manage and enforce their own specific application guardrails without requiring cluster-wide admin privileges.
- Exceptions: A specific workload requires a unique configuration (e.g., a specific storage mount) that you strictly want to allow in one namespace but nowhere else.

Note the structure of the file. Kyverno policies consist of a `match` block (which defines the resources the policy applies to, in this case, Pods) and an optional `exclude` block (which ignores namespaces like `kube-system` and `kyverno`). Finally, the `validate` block uses a `pattern` to ensure that the `privileged` field is set to `false` for all containers, initContainers, and ephemeralContainers.

We can now apply our policy:

```bash
make deploy-privileged-policy
```

We can now re-run our tests and observe that both pass:

```bash
make privileged-test
```

### Demo 2 - Enforcing and Testing Custom Policy

We can now experiment with testing a custom policy. Imagine that we have derived a control from our threat model that demands that all production images are scanned, and promoted to a private registry as long as they pass a series of policy checks. We would now like to impose a policy that only images pulled from this specific repository can be deployed as containers on our cluster. In order to mock up this scenario, we have provided a sample Golang application, which we can build and push to [ttl.sh](https://ttl.sh/) - a free anonymous and ephemeral image registry. Let's imagine that this is our private registry, and that our Golang app image has passed all required checks and can be pushed to this registry:

```bash
make image-push
```

Observe the output and copy the URL, image name and tag (with the tag specifying a 1 hour duration) which will look similar to the following: `ttl.sh/70a0da41-348f-4c49-8fd7-d5ba87ba8066:1h`. Paste this string into the marked location in the following file: `source/control-tests/allowed-repo/allowed-repo.yaml`.

We can now run a test which will check whether container images deployed to our cluster come from the `ttl.sh` registry. As we have not yet created the policy, observe that one of the two tests (defined in `source/control-tests/allowed-repo/repo-test.bats`) fails:

```bash
make repo-test
```

We can now apply the policy defined in `source/policy/allowed-repo/kyverno-policy.yaml` to enforce this constraint. Note how Kyverno handles this elegantly by allowing wildcards natively in its pattern matching, so we can simply define the allowed image as "ttl.sh/*".

Apply the appropriate policy:

```bash
make deploy-repo-policy
```

We should now see both tests passing:

```bash
make repo-test
```

By running these automated tests on a regular basis, we are continually verifying that the controls derived from our threat model are doing a good job in a representative environment!

### Teardown

```bash
make delete
```

## References

- [kind](https://kind.sigs.k8s.io/)
- [kind Installation](https://kind.sigs.k8s.io/docs/user/quick-start/#installation)
- [Docker image registry - Kindest](https://hub.docker.com/u/kindest)
- [bats-detik](https://github.com/bats-core/bats-detik)
- [Kyverno](https://kyverno.io/)
