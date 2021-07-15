.PHONY: install-kind
install:
	curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.11.1/kind-linux-amd64
	chmod +x ./kind
	sudo mv ./kind /usr/bin/kind

.PHONY: delete
delete:
	kind delete cluster --name threat-modelling
	rm -f config

.PHONY: create
create: delete
	kind create cluster --config kind/threat-modelling.yaml
	kind get kubeconfig --name threat-modelling > ./config

# TODO: grep to ensure that PSP isn't enabled
.PHONY: psp-enable
psp-enable:
	docker exec -it threat-modelling-control-plane \
	sed -i "s#enable-admission-plugins=NodeRestriction#enable-admission-plugins=NodeRestriction,PodSecurityPolicy#g" /etc/kubernetes/manifests/kube-apiserver.yaml

# TODO: grep to ensure that PSP is already enabled
.PHONY: psp-disable
psp-disable: 
	docker exec -it threat-modelling-control-plane \
	sed -i "s#enable-admission-plugins=NodeRestriction,PodSecurityPolicy#enable-admission-plugins=NodeRestriction#g" /etc/kubernetes/manifests/kube-apiserver.yaml

.PHONY: bats-detik-debug
bats-detik-debug:
	docker run -it \
		-v ${PWD}:/home/testing/sources \
		-v ${PWD}/config:/home/testing/.kube/config \
		--network="host" \
		denhamparry/bats-detik:0.0.1 \
		/bin/bash

.PHONY: bats-detik
bats-detik:
	docker run -it \
		-v ${PWD}/sources:/home/testing/sources \
		-v ${PWD}/config:/home/testing/.kube/config \
		--network="host" \
		denhamparry/bats-detik:0.0.1 \
		bats /home/testing/sources/psp-privileged-test.bats