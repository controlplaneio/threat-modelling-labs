# Threat Modelling Kubernetes - Course Materials

> Contents for the Threat Modelling workshop delivered by [Control Plane](https://control-plane.io) 

## Module 1

### BCTL Data Flow Diagram (DFD)

- An OWASP Threat Dragon json file is provided for the BCTL Level 0 Data Flow Diagram (DFD) presented in module 1: [DFD] (BCTL_L0_DFD.json)

- The following link provides instructions which may be used by students to run local, containerised instances of OWASP Threat Dragon and GitLab (for storage of models) using Docker Compose: https://hub.docker.com/r/appsecco/owasp-threat-dragon-gitlab

## Module 2

### Example Graphviz attack tree

- The source file for the example Graphviz attack tree used in Module 1 can be found at: [Example attack tree] (example_tree.dot)

- We have provided a Dockerfile that can be used to generate `.png` files from Graphviz `.dot` files: [Dockerfile](Dockerfile)

- In order to use this Dockerfile:

```bash
git clone https://github.com/controlplaneio/threat-modelling-labs
cd threat-modelling-labs/course-materials
docker build -t graphviz-render .
cat example_tree.dot | docker run --rm -i graphviz-render > example_tree.png
```

- This will output the attack tree in the `example_tree.png` file

### KinD

```bash
kind create cluster --config kind-cluster-build.yaml
kind get clusters
kind get nodes --name threat-modelling
kind get kubeconfig --name threat-modelling > threat-modelling-config.yaml
```