.PHONY: create
create: delete
	kind create cluster --config kind-config-build.yaml
	kind get kubeconfig --name threat-modelling-build > threat-modelling-config.yaml

.PHONY: delete
delete:
	kind delete cluster --name threat-modelling-build
	rm threat-modelling-config.yaml
