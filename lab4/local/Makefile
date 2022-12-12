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
	(cd /tmp/bats-detik && docker build --build-arg KUBECTL_VERSION=v1.25.2 --build-arg HELM_VERSION=v3.8.2 --build-arg BATS_VERSION=1.3.0 \-t bats-detik .)
	rm -rf /tmp/bats-detik

.PHONY: bats-detik
bats-detik: bats-detik-build
	docker run -it \
		-v ${PWD}/source:/home/testing/source \
		-v ${PWD}/config:/home/testing/.kube/config \
		--network="host" \
		bats-detik \
		bats /home/testing/source/privileged-pod-test.bats

PHONY: install-gatekeeper
install-gatekeeper: bats-detik-build
	docker run -it \
		-v ${PWD}/source:/home/testing/source \
		-v ${PWD}/config:/home/testing/.kube/config \
		--network="host" \
		bats-detik \
		/bin/bash -c "git clone https://github.com/open-policy-agent/gatekeeper.git /tmp/gatekeeper && \
		cd /tmp/gatekeeper && git checkout 91d29f6c9cc7a41bc0a8b766e4b6a138a529777f && \
		cd /tmp/gatekeeper/deploy && kubectl apply -f gatekeeper.yaml"

PHONY: deploy-constraint
deploy-constraint: bats-detik-build
	docker run -it \
		-v ${PWD}/source:/home/testing/source \
		-v ${PWD}/config:/home/testing/.kube/config \
		--network="host" \
		bats-detik \
		/bin/bash -c "kubectl apply -f /home/testing/source/priv-constraint-template.yaml && \
		kubectl apply -f /home/testing/source/priv-container-constraint.yaml"

