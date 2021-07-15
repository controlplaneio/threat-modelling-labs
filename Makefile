.PHONY: create
create: delete
	kind create cluster --config kind-config-build.yaml
	kind get kubeconfig --name threat-modelling-build > threat-modelling-config.yaml

.PHONY: delete
delete:
	kind delete cluster --name threat-modelling-build
	rm threat-modelling-config.yaml

# TODO: grep to ensure that PSP isn't enabled
.PHONY: psp-enable
psp-enable:
	docker exec -it threat-modelling-build-control-plane \
	sed -i "s#enable-admission-plugins=NodeRestriction#enable-admission-plugins=NodeRestriction,PodSecurityPolicy#g" /etc/kubernetes/manifests/kube-apiserver.yaml

# TODO: grep to ensure that PSP is already enabled
.PHONY: psp-disable
psp-disable: 
	docker exec -it threat-modelling-build-control-plane \
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
		-v ${PWD}:/home/testing/sources \
		-v ${PWD}/config:/home/testing/.kube/config \
		--network="host" \
		denhamparry/bats-detik:0.0.1 \
		bats /home/testing/sources/priv-test.bats