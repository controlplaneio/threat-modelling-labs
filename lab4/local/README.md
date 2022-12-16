# Lab 4 - Testing Kubernetes (Local)

- [Back to Threat Modelling Lab 4](/lab4/README.md)

> Contents for the Threat Modelling workshop delivered by [Control Plane](https://control-plane.io).

This lab can be run locally using the following instructions. 

## Prerequisite

> The following demo is built for Linux. You will need the following tools:

- [Make](https://www.gnu.org/software/make/manual/make.html)
- [Docker](https://www.docker.com)
- [KinD](https://kind.sigs.k8s.io/docs/user/quick-start/)

## Demo

### Introduction and Setup

Create a kind cluster which we will use for this lab:  

```bash
make create
```

In this exercise, we will be enforcing admission control policies for resources we wish to deploy to our cluster. [Pod Security Standards](https://kubernetes.io/docs/concepts/security/pod-security-standards/) provide a great way to enforce pod hardening best practices quickly and easily. However, note that we did not configure the Kubernetes API server with a suitable admission configuration at cluster creation (as per https://kubernetes.io/docs/tutorials/security/cluster-level-pss/):

```bash
cat kind/threat-modelling.yaml
```
As an instructive task in defining and testing controls derived from our threat model, we are instead going to demonstrate how [Gatekeeper](https://github.com/open-policy-agent/gatekeeper) can be used to go beyond Pod Security Standards (PSS) and define *custom* policies using Rego, the language of [Open Policy Agent (OPA)](https://github.com/open-policy-agent/opa). It should be noted that in accordance with the Module 3 Lab, the choice between different implementation methods for a control ultimately comes down to an effort vs benefit decision, and for many use cases, simply using Baseline or Restricted Pod Security Standards will be the most efficient way to protect against our biggest threats. However, if your threat profile is deemed to be sufficient to require more intricate controls, the overhead of maintaining custom Rego policies may be seen as worthwhile.  

In this lab, we will first use Gatekeeper to prevent privileged pods from running. Note that the privileged flag is only one dangerous configuration that is prevented by the Baseline PSS, and in practice we would want to enforce a more complete policy. However, for the purposes of demonstrating how we can test the effectiveness of controls, this example will suffice. To demonstrate how we can develop custom controls and test their effectiveness, we will then develop a second Gatekeeper policy to only permit images to be pulled from an approved repository. This mimics a control where production images are scanned, and promoted to a specific internal artefact repository provided they conform to organisational policies, and any vulnerabilities have been appropriately triaged in accordance with agreed procedures. 

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

### Demo 1b - Install Gatekeeper and enforce validating admission control policy

Deploy Gatekeeper to the cluster:

```bash
make install-gatekeeper
```
Enforcing policies using gatekeeper amounts to creating Constraint Templates and Constraints. We will use [Konstraint](https://github.com/plexsystems/konstraint) in order to generate Constraint Templates and Constraints using the Rego source files as the source of truth (meaning that we do not have to update the Rego and the YAML independently). Observe the Rego that we will use to generate our privileged constraint:
```bash
cat source/policy/privileged/src.rego
```
Note the metadata at the top of the file, which defines how our constraint will be created, i.e. the policy (which will be translated into a constraint template) will apply to Pods in any namespace apart from `kube-system` and `gatekeeper-system`. 

The `constraint.yaml` and `template.yaml` files in the same folder as the source Rego can be regenerated (in case the Rego has been changed) by running:
```bash
make generate_constraint_templates
```
We can now apply our policy:
```bash
make deploy-privileged-constraint
```

We can now re-run our tests and observe that both pass:
```bash
make privileged-test
```

### Demo 2 - Enforcing and Testing Custom Policy

We can now experiment with testing a custom policy. Imagine that we have derived a control from our threat model that demands that all production images are scanned, and promoted to a private registry as long as they pass a series of policy checks. We would now like to impose a constraint that only images pulled from this specific repository can be deployed as containers on our cluster. In order to mock up this scenario, we have provided a sample Golang application, which we can build and push to https://ttl.sh/ - a free anonymous and ephemeral image registry. Let's imagine that this is our private registry, and that our Golang app image has passed all required checks and can be pushed to this registry:
```bash
make image-push
```
Observe the output and copy the URL, image name and tag (with the tag specifying a 1 hour duration) which will look similar to the following: `ttl.sh/70a0da41-348f-4c49-8fd7-d5ba87ba8066:1h`. Paste this string into the marked location in the following file: `source/control-tests/allowed-repo/allowed-repo.yaml`. 

We can now run a test which will check whether container images deployed to our cluster come from the `ttl.sh` registry. As we have not yet created the policy, observe that one of the two tests (defined in `source/control-tests/allowed-repo/repo-test.bats`) fails:
```bash
make repo-test
```
We can now apply the policy defined in `source/policy/allowed-repo/src.rego` to enforce this constraint. Note that the metadata at the top of this file includes the following block:
```bash
# custom:
#   parameters:
#     repos:
#       type: array
#       description: Array of acceptable repos
#       items:
#         type: string
```
This defines an array of strings, which will represent the allowed repos that our images can be pulled from. Due to the addition of this custom input parameter, Konstraint will not generate the `constraint.yaml` file (https://github.com/plexsystems/konstraint/blob/main/docs/constraint_creation.md#using-input-parameters), so this must be maintained manually. We can now apply the appropriate policy:
```bash
make deploy-repo-constraint
```
We should now see both tests passing:
```bash
make repo-test
```

### Demo 3 - Multiple Layers of Testing
In the policy folder, we have provided unit tests (in the `src_test.rego` files) for both Rego packages: `package privileged_check` and `package allowed_repo`. OPA Policy Testing can be performed in accordance with https://www.openpolicyagent.org/docs/latest/policy-testing/, using the `with input as...` construct to mock up the input data on which Gatekeeper makes its policy decision. We can run our unit tests as follows:
```bash
make opa_unit_tests
```

Note that this tests the policy implementation using mocked data. What we have done in this lab is verified our controls using multiple levels of testing, include verifying the effectiveness of the applied controls in a representative environment. By running these tests on a regular basis, we are continually verifying that the controls derived from our threat model are doing a good job!

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