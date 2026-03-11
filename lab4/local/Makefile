KUBECTL_VERSION := v1.35.0
HELM_VERSION := v4.1.1
BATS_VERSION := 1.13.0
KIND_VERSION := v0.31.0
KYVERNO_VERSION := v1.17.1

IMAGE_NAME := $(shell uuidgen)

.PHONY: delete
delete:
	kind delete cluster --name threat-modelling
	rm -f config
	find . -type d -exec chmod 755 {} \;
	find . -type f -exec chmod 644 {} \;
	sed -i 's|image:.*|image: #paste your image here |g' source/control-tests/allowed-repo/allowed-repo.yaml

.PHONY: install-kind
install-kind:
	curl -Lo "${HOME}"/kind https://kind.sigs.k8s.io/dl/${KIND_VERSION}/kind-linux-amd64
	chmod +x "${HOME}"/kind
	sudo mv "${HOME}"/kind /usr/local/bin/kind

.PHONY: create
create: delete
	kind create cluster --config kind/threat-modelling.yaml
	kind get kubeconfig --name threat-modelling > ./config

.PHONY: bats-detik-build
bats-detik-build:
	rm -rf /tmp/bats-detik
	git clone https://github.com/bats-core/bats-detik.git /tmp/bats-detik
	(cd /tmp/bats-detik && git checkout ce86871d7fdaed7f31b0e11e228b7b91a58ac1cc)
	(chmod 777 /tmp/bats-detik/lib/*)
	(cd /tmp/bats-detik && sed -i 's|storage.googleapis.com/kubernetes-release|dl.k8s.io|g' Dockerfile)
	(cd /tmp/bats-detik && docker build --build-arg KUBECTL_VERSION=${KUBECTL_VERSION} --build-arg HELM_VERSION=${HELM_VERSION} --build-arg BATS_VERSION=${BATS_VERSION} \-t bats-detik .)
	rm -rf /tmp/bats-detik

.PHONY: privileged-test
privileged-test: bats-detik-build
	chmod 777 ./config && chmod -R 777 ./source 
	-docker run -it \
		-v "${PWD}"/source:/home/testing/source \
		-v "${PWD}"/config:/home/testing/.kube/config \
		--network="host" \
		bats-detik \
		bats /home/testing/source/control-tests/privileged/privileged-test.bats

.PHONY: repo-test
repo-test: bats-detik-build
	chmod 777 ./config && chmod -R 777 ./source 
	docker run -it \
		-v "${PWD}"/source:/home/testing/source \
		-v "${PWD}"/config:/home/testing/.kube/config \
		--network="host" \
		bats-detik \
		bats /home/testing/source/control-tests/allowed-repo/repo-test.bats		

.PHONY: install-kyverno
install-kyverno: bats-detik-build
	chmod 777 ./config && chmod -R 777 ./source 
	docker run -it \
		-v "${PWD}"/source:/home/testing/source \
		-v "${PWD}"/config:/home/testing/.kube/config \
		--network="host" \
		bats-detik \
		/bin/bash -c "helm repo add kyverno https://kyverno.github.io/kyverno/ && \
		helm upgrade --install kyverno kyverno/kyverno \
		-n kyverno --create-namespace"

.PHONY: deploy-privileged-policy
deploy-privileged-policy: bats-detik-build
	chmod 777 ./config && chmod -R 777 ./source 
	docker run -it \
		-v "${PWD}"/source:/home/testing/source \
		-v "${PWD}"/config:/home/testing/.kube/config \
		--network="host" \
		bats-detik \
		/bin/bash -c "kubectl apply -f /home/testing/source/policy/privileged/kyverno-policy.yaml"

.PHONY: deploy-repo-policy
deploy-repo-policy: bats-detik-build
	chmod 777 ./config && chmod -R 777 ./source 
	docker run -it \
		-v "${PWD}"/source:/home/testing/source \
		-v "${PWD}"/config:/home/testing/.kube/config \
		--network="host" \
		bats-detik \
		/bin/bash -c "kubectl apply -f /home/testing/source/policy/allowed-repo/kyverno-policy.yaml"

.PHONY: image-push
image-push:
	docker build -t ttl.sh/${IMAGE_NAME}:1h ./golang-app
	docker push ttl.sh/${IMAGE_NAME}:1h
