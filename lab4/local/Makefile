KUBECTL_VERSION := v1.25.2
HELM_VERSION := v3.8.2
BATS_VERSION := 1.8.2

OPA_VERSION := 0.47.3
OPA_IMAGE := openpolicyagent/opa:$(OPA_VERSION)

KONSTRAINT_VERSION := v0.24.0
KONSTRAINT_IMAGE := ghcr.io/plexsystems/konstraint:$(KONSTRAINT_VERSION)

IMAGE_NAME := $(shell uuidgen)

.PHONY: delete
delete:
	kind delete cluster --name threat-modelling
	rm -f config

.PHONY: create
create: delete
	kind create cluster --config kind/threat-modelling.yaml
	kind get kubeconfig --name threat-modelling > ./config

.PHONY: bats-detik-build
bats-detik-build:
	rm -rf /tmp/bats-detik
	git clone https://github.com/bats-core/bats-detik.git /tmp/bats-detik
	(cd /tmp/bats-detik && git checkout e3ea96e14bfd8d2637fc827c1d801f4c576d2cfc)
	(cd /tmp/bats-detik && docker build --build-arg KUBECTL_VERSION=${KUBECTL_VERSION} --build-arg HELM_VERSION=${HELM_VERSION} --build-arg BATS_VERSION=${BATS_VERSION} \-t bats-detik .)
	rm -rf /tmp/bats-detik

.PHONY: privileged-test
privileged-test: bats-detik-build
	docker run -it \
		-v ${PWD}/source:/home/testing/source \
		-v ${PWD}/config:/home/testing/.kube/config \
		--network="host" \
		bats-detik \
		bats /home/testing/source/control-tests/privileged/privileged-test.bats

.PHONY: repo-test
repo-test: bats-detik-build
	docker run -it \
		-v ${PWD}/source:/home/testing/source \
		-v ${PWD}/config:/home/testing/.kube/config \
		--network="host" \
		bats-detik \
		bats /home/testing/source/control-tests/allowed-repo/repo-test.bats		

PHONY: install-gatekeeper
install-gatekeeper: bats-detik-build
	docker run -it \
		-v ${PWD}/source:/home/testing/source \
		-v ${PWD}/config:/home/testing/.kube/config \
		--network="host" \
		bats-detik \
		/bin/bash -c "helm repo add gatekeeper https://open-policy-agent.github.io/gatekeeper/charts && \
		helm install gatekeeper/gatekeeper  \
		--version 3.10.0 \
    --name-template=gatekeeper \
    --namespace gatekeeper-system --create-namespace \
    --set enableExternalData=true \
    --set controllerManager.dnsPolicy=ClusterFirst,audit.dnsPolicy=ClusterFirst"

.PHONY: generate_constraint_templates
generate_constraint_templates:
	docker run --rm -w /src -v $(PWD):/src $(KONSTRAINT_IMAGE) \
		create source/policy/

PHONY: deploy-privileged-constraint
deploy-privileged-constraint: bats-detik-build
	docker run -it \
		-v ${PWD}/source:/home/testing/source \
		-v ${PWD}/config:/home/testing/.kube/config \
		--network="host" \
		bats-detik \
		/bin/bash -c "kubectl apply -f /home/testing/source/policy/privileged/template.yaml && \
		kubectl apply -f /home/testing/source/policy/privileged/constraint.yaml"

PHONY: deploy-repo-constraint
deploy-repo-constraint: bats-detik-build
	docker run -it \
		-v ${PWD}/source:/home/testing/source \
		-v ${PWD}/config:/home/testing/.kube/config \
		--network="host" \
		bats-detik \
		/bin/bash -c "kubectl apply -f /home/testing/source/policy/allowed-repo/template.yaml && \
		kubectl apply -f /home/testing/source/policy/allowed-repo/constraint.yaml"

.PHONY: opa_unit_tests
opa_unit_tests:
	docker run --rm -w /src -v $(PWD):/src $(OPA_IMAGE) \
		test source/policy/ -v --ignore *.yaml --ignore *.yml

.PHONY: image-push
image-push:
	docker build -t ttl.sh/${IMAGE_NAME}:1h ./golang-app
	docker push ttl.sh/${IMAGE_NAME}:1h